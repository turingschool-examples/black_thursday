require_relative 'test_helper.rb'
require_relative '../lib/invoice'
require_relative '../lib/sales_engine'

class InvoiceTest < Minitest::Test
  attr_reader :i
  def setup 
    @i = Invoice.new({
      :id => 25,
      :customer_id => 33,
      :merchant_id => 12335938,
      :status => "pending",
      :created_at => "2007-06-04 21:35:10 UTC",
      :updated_at => "2016-01-11 09:34:06 UTC"
      })
  end
  
  def test_it_exists
    assert_instance_of Invoice, i
  end

  def test_it_knows_id
    assert_equal 25, i.id
  end

  def test_it_knows_customer_id
    assert_equal 33, i.customer_id
  end

  def test_it_returns_merchant_id
    assert_equal 12335938, i.merchant_id
  end

  def test_it_knows_unit_price
    assert_equal :pending, i.status
  end

  def test_it_knows_what_time_it_was_created
    assert_instance_of Time, i.created_at
    assert_equal 2007, i.created_at.year
  end

  def test_it_knows_what_time_it_was_udpated
    assert_instance_of Time, i.updated_at
    assert_equal 2016, i.updated_at.year
  end
  
  def test_it_can_find_merchant_based_on_invoice_id
    se = SalesEngine.from_csv({
        :merchants     => "./test/fixtures/temp_merchants.csv",
        :items     => "./test/fixtures/temp_items.csv",
        :invoices => "./test/fixtures/invoices_truncated.csv"
        })
    invoice = se.invoices.find_by_id(25)
    
    assert_instance_of Merchant, invoice.merchant
    assert_equal "Candi", invoice.merchant.name
  end
end
