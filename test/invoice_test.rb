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
    :invoices => "./test/fixtures/invoices_fixture.csv"
    })
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

    assert_instance_of Date, invoice_1.date
    assert_equal 'Saturday', invoice_1.day_of_the_week
    assert_equal 'Friday', invoice_2.day_of_the_week
  end

end
