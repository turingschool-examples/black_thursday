require_relative 'test_helper'
require_relative '../lib/invoice'


class InvoicesTest < Minitest::Test

  attr_reader :invoice

  def setup
    invoice_data = {:id          => 6,
                    :customer_id => 7,
                    :merchant_id => 8,
                    :status      => "pending",
                    :created_at  => "2012-01-07 15:15:22 -0700",
                    :updated_at  => "2018-01-07 15:15:22 -0700"}
    parent = mock("repository")
    @invoice = Invoice.new(invoice_data, parent)
  end

  def test_it_returns_items_by_id_in_invoice_items
    ii = mock('invoice_item')
    ii_2 = mock('invoice_item2')
    ii_3 = mock('invoice_item3')
    invoice.invoice_repo.stubs(:find_invoice_items_by_id).returns([ii, ii_2, ii_3])


    assert_equal [ii, ii_2, ii_3], invoice.invoice_items
  end

  def test_it_returns_transactions_by_invoice_id
    skip
    item1 = mock('item')
    item2 = mock('item2')
    item3 = mock('item3')
    ii = stub(item_id: item1)
    ii_2 = stub(item_id: item2)
    ii_3 = stub(item_id: item3)
    invoice.invoice_repo.stubs(:find_invoice_items_by_id).returns([ii, ii_2, ii_3])
    invoice.invoice_repo.stubs(:find_item_by_id).

    assert_equal [item1, item2, item3], invoice.items
  end

  def test_it_returns_customers_by_invoice_id
    skip
    se = SalesEngine.from_csv({
      invoices: "./test/fixtures/invoices_sample.csv",
      customers: "./test/fixtures/customers_sample.csv",
      items: "./test/fixtures/items_sample.csv"
    })

    invoice = se.invoices.find_by_id(819)

    assert_instance_of Customer, invoice.customer
    assert_equal 819, invoice.id
  end

  def test_it_returns_merchant_by_invoice_id
    skip
    se = SalesEngine.from_csv({
      invoices: "./test/fixtures/invoices_sample.csv",
      customers: "./test/fixtures/customers_sample.csv",
      items: "./test/fixtures/items_sample.csv"
    })
    invoice = se.invoices.find_by_id(2179)

    assert_equal 12334633, invoice.merchant_id
    refute_equal "12334633", invoice.merchant_id
  end

  def test_it_returns_success_for_is_paid_in_full
    skip
    se = SalesEngine.from_csv({
      invoices: "./test/fixtures/invoices_sample.csv",
      transactions: "./test/fixtures/transactions_sample.csv",
      items: "./test/fixtures/items_sample.csv"
    })
    invoice = se.invoices.find_by_id(2179)

    assert_equal 2, invoice.transactions.count
  end

  def test_it_returns_total_dollar_amount_for_invoice
    skip
    se = SalesEngine.from_csv({
      invoices: "./test/fixtures/invoices_sample.csv",
      transactions: "./test/fixtures/transactions_sample.csv",
      invoice_items: "./test/fixtures/invoice_items_sample.csv",
      items: "./test/fixtures/items_sample.csv"
    })
    invoice = se.invoices.find_by_id(641)

    assert_equal 0.429506e4, invoice.total
    refute_equal 4.29506e4, invoice.total
  end

end
