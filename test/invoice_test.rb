require_relative '../lib/sales_engine'
require 'bigdecimal'
require 'time'
require_relative '../lib/invoice'
require 'csv'
require 'minitest/autorun'
require 'minitest/emoji'

class InvoiceTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
              :items => "./test/data/items_fixture.csv",
              :merchants => "./test/data/merchants_fixture.csv",
              :invoice_items => "./test/data/invoice_items_fixture.csv",
              :invoices => "./test/data/invoices_fixture.csv",
              :transactions => "./test/data/transactions_fixture.csv",
              :customers => "./test/data/customers_fixture.csv"
            })
    @i = Invoice.new({
              :id          => 6,
              :customer_id => 7,
              :merchant_id => 8,
              :status      => "pending",
              :created_at  => Time.now,
              :updated_at  => Time.now,
            }, @se.invoices)
    @invoice = @se.invoices.find_by_id(74)
  end

  def test_has_instance_variables
    assert_instance_of InvoiceRepository, @i.invoice_repo
    assert_equal 6, @i.id
    assert_equal 7, @i.customer_id
    assert_equal 8, @i.merchant_id
    assert_equal :pending, @i.status
    assert_instance_of Time, @i.created_at
    assert_instance_of Time, @i.updated_at
  end

  def test_merchant
    assert_instance_of Merchant, @invoice.merchant
  end

end
