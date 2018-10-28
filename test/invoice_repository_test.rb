require_relative './helper'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice'
require_relative '../lib/sales_engine'
class InvoiceRepositoryTest < Minitest::Test
  def setup
    se = SalesEngine.from_csv( {
        :items      => './data/items.csv',
        :merchants  => './data/merchants.csv',
        :invoices   => './data/invoices.csv'
                                } )
    @invoices = se.invoices
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @invoices
  end

  def test_it_can_return_array_of_all_items
    assert_equal 4985, @invoices.all.count
  end

  def test_it_can_find_by_id
    assert_instance_of Invoice, @invoices.find_by_id(3)
  end

  def test_it_can_find_by_customer_id
    assert_equal [], @invoices.find_by_customer_id(12111111)
    assert_equal 5, @invoices.find_by_customer_id(6).count
  end

  def test_it_can_find_by_merchant_id
    assert_equal [], @invoices.find_by_merchant_id(12111111)
    assert_equal 5, @invoices.find_by_customer_id(12335938).count
  end
end
