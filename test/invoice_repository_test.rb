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
    @time_now = Time.now
    @updated_time = Time.now
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
    assert_equal [], @invoices.find_all_by_customer_id(12111111)
    assert_equal 5, @invoices.find_all_by_customer_id(6).count
  end

  def test_it_can_find_by_merchant_id
    assert_equal [], @invoices.find_all_by_merchant_id(12111111)
    assert_equal 16, @invoices.find_all_by_merchant_id(12335938).count
  end

  def test_it_can_find_all_by_status
    assert_equal [], @invoices.find_all_by_status('old')
    assert_equal 673, @invoices.find_all_by_status('returned').count
  end

  def test_it_can_create_new_item
    actual = @invoices.create( {customer_id: '7392',
                                merchant_id: '51338418',
                                status:      'returned',
                                created_at:  '@time_now',
                                updated_at:  '@updated_time'} )
    assert_instance_of Invoice, actual
    assert_equal 4986, @invoices.all.last.id
  end

  def test_it_can_update_attributes
    @invoices.update(31, {status: 'returned'})
    assert_equal 'returned', @invoices.find_by_id(31).status
  end

  def test_it_can_delete_an_item
    actual = @invoices.create( { customer_id: '7392',
                                 merchant_id: '51338418',
                                 status:      'returned',
                                 created_at:  '@time_now',
                                 updated_at:  '@updated_time'} )
    assert_instance_of Invoice, actual
    @invoices.delete(4986)
    refute @invoices.all.any? { |invoice| invoice.id == 4986}
  end
end
