require './test/test_helper'
require './lib/invoice'
require './lib/sales_engine'
require 'csv'
require 'bigdecimal'

class InvoiceIsolationTest < Minitest::Test
  attr_reader :invoice_rows, :invoice_1

  def setup
    fixture = CSV.open('./test/fixtures/invoices_fixture.csv',
                         headers:true,
                         header_converters: :symbol)
    @invoice_rows = fixture.to_a
    @invoice_1 = Invoice.new(invoice_rows[0])
  end

  def test_has_status
    assert_equal :pending, invoice_1.status
  end

  def test_has_fixnum_ids
    assert_equal 1, invoice_1.id
    assert_equal 100, invoice_1.customer_id
    assert_equal 1000, invoice_1.merchant_id
  end

  def test_has_time_objects
    assert_instance_of Time, invoice_1.created_at
    assert_instance_of Time, invoice_1.updated_at
  end

  def test_method_is_paid_in_full_returns_boolean
    mock_inv_r = Minitest::Mock.new
    invoice_1 = Invoice.new(@invoice_rows[0], mock_inv_r)
    invoice_4 = Invoice.new(@invoice_rows[3], mock_inv_r)

    mock_t1 = Minitest::Mock.new
    mock_t2 = Minitest::Mock.new
    mock_t3 = Minitest::Mock.new
    mock_t1.expect(:is_successful?, true)
    mock_t2.expect(:is_successful?, false)
    mock_t3.expect(:is_successful?, false)

    mock_inv_r.expect(:find_transactions_by_id, [mock_t2, mock_t1], [invoice_1.id])
    mock_inv_r.expect(:find_transactions_by_id, [mock_t3], [invoice_4.id])

    assert_equal true, invoice_1.is_paid_in_full?
    assert_equal false, invoice_4.is_paid_in_full?

    assert mock_inv_r.verify
    assert mock_t1.verify
    assert mock_t2.verify
    assert mock_t3.verify
  end

  def test_method_merchant_queries_parent
    mock_inv_r = Minitest::Mock.new
    invoice = Invoice.new(invoice_rows[0], mock_inv_r)
    mock_inv_r.expect(:find_merchant_by_id, nil, [1000])
    invoice.merchant
    assert mock_inv_r.verify
  end

  def test_method_items_queries_parent
    mock_inv_r = Minitest::Mock.new
    invoice = Invoice.new(invoice_rows[0], mock_inv_r)
    mock_inv_r.expect(:find_items_by_id, nil, [1])
    invoice.items
    assert mock_inv_r.verify
  end

  def test_method_transactions_queries_parent
    mock_inv_r = Minitest::Mock.new
    invoice = Invoice.new(invoice_rows[0], mock_inv_r)
    mock_inv_r.expect(:find_transactions_by_id, nil, [1])
    invoice.transactions
    assert mock_inv_r.verify
  end

  def test_method_customer_queries_parent
    mock_inv_r = Minitest::Mock.new
    invoice = Invoice.new(invoice_rows[0], mock_inv_r)
    mock_inv_r.expect(:find_customer_by_id, nil, [100])
    invoice.customer
    assert mock_inv_r.verify
  end

  def test_method_invoice_items_queries_parent
    mock_inv_r = Minitest::Mock.new
    invoice = Invoice.new(invoice_rows[0], mock_inv_r)
    mock_inv_r.expect(:find_invoice_items_by_id, nil, [1])
    invoice.invoice_items
    assert mock_inv_r.verify
  end

  def test_method_weekday_created_returns_string
    assert_equal "Saturday", invoice_1.weekday_created
  end
end

class InvoiceIntegrationTest < Minitest::Test
  attr_reader :se, :invoice_1, :invoice_4

  def setup
    @se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_fixture.csv",
      :merchants => "./test/fixtures/merchants_fixture.csv",
      :invoices  => "./test/fixtures/invoices_fixture.csv",
      :invoice_items => "./test/fixtures/invoice_items_fixture.csv",
      :transactions => "./test/fixtures/transactions_fixture.csv",
      :customers => "./test/fixtures/customers_fixture.csv",

    })
    @invoice_1 = se.all_invoices[0]
    @invoice_4 = se.all_invoices[3]
  end

  def test_method_is_paid_in_full_returns_boolean
    assert_equal true, invoice_1.is_paid_in_full?
    assert_equal false, invoice_4.is_paid_in_full?
  end

  def test_method_total_returns_bigdecimal
    assert_equal 15990.93, invoice_1.total
    assert_equal nil, invoice_4.total
  end
end
