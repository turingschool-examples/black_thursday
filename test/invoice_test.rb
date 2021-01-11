require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/invoice_repo'
require './lib/invoice'
require './lib/sales_engine'
require './lib/merchant'
require './lib/merchant_repo'
require './lib/item'
require './lib/item_repo'

class InvoiceTest < MiniTest::Test

  def test_it_exists
    se = SalesEngine.from_csv({:invoices => "./data/invoices.csv"})
    i = Invoice.new({
                    :id          => 6,
                    :customer_id => 7,
                    :merchant_id => 8,
                    :status      => "pending",
                    :created_at  => Time.now,
                    :updated_at  => Time.now,
                    })
    assert_instance_of Invoice, i
  end

  def test_invoice_attributes
    se = SalesEngine.from_csv({:invoices => "./data/invoices.csv"})
    i = Invoice.new({
                    :id          => 6,
                    :customer_id => 7,
                    :merchant_id => 8,
                    :status      => "pending",
                    :created_at  => Time.now,
                    :updated_at  => Time.now,
                    })
    expected = se.invoices.find_by_id(3452)
    assert_equal 3452, expected.id
    assert_equal 679, expected.customer_id
    assert_equal 12335690, expected.merchant_id
    assert_equal :pending, expected.status
    assert_instance_of Time, expected.created_at
    assert_instance_of Time, expected.updated_at
  end
end
