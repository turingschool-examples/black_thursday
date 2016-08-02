require './test/test_helper'
require './lib/invoice'
require 'csv'

class InvoiceTest < Minitest::Test
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

  def test_method_weekday_created_returns_string
    assert_equal "Saturday", invoice_1.weekday_created
  end
end
