require_relative 'test_helper'
require_relative '../lib/invoice'
require_relative '../lib/sales_engine'
require 'time'
require 'date'

class InvoiceTest < Minitest::Test
  def setup
    se = SalesEngine.from_csv({
    :items     => "./test/fixtures/items_fixture.csv",
    :merchants => "./test/fixtures/merchants_fixture.csv",
    :invoices => "./test/fixtures/invoices_fixture.csv",
    :transactions => "./test/fixtures/transactions_fixture.csv",
    :invoice_items => './test/fixtures/invoice_items_fixture.csv',
    :customers => "./test/fixtures/customers_fixture.csv"
    })
    se.items
    se.merchants
    se.transactions
    se.invoice_items
    se.customers
    vr = se.invoices
  end

  def test_it_exists
    i = Invoice.new({
        :id          => 6,
        :customer_id => 7,
        :merchant_id => 8,
        :status      => "pending",
        :created_at  => '2009-02-07',
        :updated_at  => '2009-02-08',
        }, 'invoice_repository')

    assert_instance_of Invoice, i
  end

  def test_it_can_display_attributes
    i = Invoice.new({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => :pending,
      :created_at  => '2009-02-07',
      :updated_at  => '2009-02-08',
      }, 'invoice_repository')

    assert_equal 6, i.id
    assert_equal 7, i.customer_id
    assert_equal 8, i.merchant_id
    assert_equal :pending, i.status
    assert_equal Time.parse('2009-02-07'), i.created_at
    assert_equal Time.parse('2009-02-08'), i.updated_at
  end

  def test_invoice_can_return_its_merchant
    vr = setup
    invoice = vr.find_by_id(74)

    assert_equal 12334105,invoice.merchant.id
  end

  def test_it_has_a_date
    vr = setup

    invoice_1 = invoice = vr.find_by_id(74)
    invoice_2 = invoice = vr.find_by_id(602)

    # assert_instance_of Date, invoice_1.date
    assert_equal 'Friday', invoice_1.day_of_the_week
    assert_equal 'Thursday', invoice_2.day_of_the_week
  end

  def test_it_can_be_connected_with_items
    vr = setup

    invoice = vr.find_by_id(74)

    assert_instance_of Array, invoice.items
    assert_instance_of Item, invoice.items[0]
    assert_equal 'Knitted winter snood', invoice.items[0].name
  end

  def test_it_can_be_connected_with_transactions
    vr = setup

    invoice = vr.find_by_id(74)

    assert_instance_of Array, invoice.transactions
    assert_instance_of Transaction, invoice.transactions[0]
    assert_equal 941, invoice.transactions[0].id
  end

  def test_it_can_be_connected_with_a_customer
    vr = setup

    invoice = vr.find_by_id(139)

    assert_instance_of Customer, invoice.customer
    assert_equal 'Osinski', invoice.customer.last_name
  end

  def test_is_paid_in_full_with_all_transactions_successful
    vr = setup
    invoice = vr.find_by_id(74)

    assert invoice.is_paid_in_full?
  end

  def test_is_not_paid_in_full_with_a_failing_transaction
    vr = setup

    invoice = vr.find_by_id(1695)

    refute invoice.is_paid_in_full?
  end

  def test_is_not_paid_in_full_without_any_transactions
    vr = setup

    invoice = vr.find_by_id(36)

    refute invoice.is_paid_in_full?
  end

end
