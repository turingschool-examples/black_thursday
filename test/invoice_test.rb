require_relative 'test_helper'
require_relative '../lib/invoice'
require_relative '../lib/sales_engine'

class InvoiceTest < Minitest::Test

  def setup
    @i1 = Invoice.new({"id"        => '1',
                  "customer_id" => '34',
                  "merchant_id" => '11',
                  "status"      => "pending",
                  "created_at"  => '1993-09-29 11:56:40 UTC',
                  "updated_at"  => '1993-09-29 11:56:40 UTC'
                 })
    @files = {:items => './test/data/items_test.csv',
              :merchants => './test/data/merchants_test_3.csv',
              :invoices => './test/data/invoices_test.csv',
              :invoice_items => './test/data/invoice_items_test.csv',
              :transactions  => './test/data/transactions_test.csv',
              :customers     => './test/data/customers_test.csv'}
  end

  def test_it_exists

    assert_instance_of Invoice, @i1
  end

  def test_initialize_can_format_data

        assert_equal 1, @i1.id
        assert_equal 34, @i1.customer_id
        assert_equal 11, @i1.merchant_id
        assert_equal :pending, @i1.status
        assert_instance_of Time, @i1.created_at
        assert_instance_of Time, @i1.updated_at
  end

  def test_merchant_returns_instance_of_merchant
    se = SalesEngine.from_csv(@files)
    invoice = se.invoices.find_by_id(1)
    actual = invoice.merchant

    assert_instance_of Merchant, actual
  end

  def test_items_returns_array_of_items
    se = SalesEngine.from_csv(@files)
    invoice_1 = se.invoices.find_by_id(12)
    invoice_2 = se.invoices.find_by_id(32)

    actual_1 = invoice_1.items
    expected = se.items.all[0]

    assert_equal [expected], actual_1
  end

  def test_transactions_returns_array_of_transactions
    se = SalesEngine.from_csv(@files)

    invoice = se.invoices.find_by_id(12)

    actual = invoice.transactions
    expected = se.transactions.all[9]

    assert_equal [expected], actual
  end

  def test_customer_returns_instance_of_customer
    se = SalesEngine.from_csv(@files)
    invoice = se.invoices.find_by_id(1)

    actual = invoice.customer
    expected = se.customers.all[0]

    assert_equal expected, actual
  end

  def test_paid_in_full_returns_correct_boolean
    se = SalesEngine.from_csv(@files)
    invoice_1 = se.invoices.find_by_id(12)
    invoice_2 = se.invoices.find_by_id(11)
    invoice_3 = se.invoices.find_by_id(8)

    actual_1 = invoice_1.is_paid_in_full?
    actual_2 = invoice_2.is_paid_in_full?
    actual_3 = invoice_3.is_paid_in_full?

    assert actual_1
    refute actual_2
    refute actual_3
  end

  def test_invoice_total_returns_amount
    se = SalesEngine.from_csv(@files)
    invoice_1 = se.invoices.find_by_id(1)
    invoice_3 = se.invoices.find_by_id(12)

    actual_1 = invoice_1.total
    actual_2 = invoice_3.total

    assert_nil actual_1
    assert_equal 55.77, actual_2
  end
end
