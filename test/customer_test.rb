require './test/test_helper'

class CustomerTest < Minitest::Test
  attr_reader :c,
              :parent
  def setup
    @parent = SalesEngine.from_csv({:customers => './test/fixtures/customer_three.csv'})
    @c = Customer.new({
      :id => 6,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => "2012-03-27 14:54:09 UTC",
      :updated_at => "2013-03-27 14:54:09 UTC"
      }, parent)
  end

def test_it_exists
    assert_instance_of Customer, c
  end

  def test_it_knows_its_id
    assert_equal 6, c.id  
  end

  def test_it_knows_its_first_name
    assert_equal "Joan", c.first_name
  end

  def test_it_knows_its_last_name
    assert_equal "Clarke", c.last_name
  end

  def test_it_knows_date_created_at
    assert_instance_of Time, c.created_at
    assert_equal "2012-03-27 14:54:09 UTC", c.created_at.to_s
  end
  
  def test_it_knows_date_updated_at
    assert_instance_of Time, c.updated_at
    assert_equal "2013-03-27 14:54:09 UTC", c.updated_at.to_s
  end

  def test_parent_is_instance_of_customer_repository
    se = SalesEngine.from_csv({:customers => './test/fixtures/customer_three.csv'})
    cr = se.customers
    c = cr.all.first

    assert_instance_of CustomerRepository, c.parent
  end

  def test_it_can_find_merchant
    se = SalesEngine.from_csv({:merchants => './data/merchants.csv',
                               :items => './test/fixtures/items_100.csv',
                               :invoices => './test/fixtures/invoices_100.csv',
                               :invoice_items => './test/fixtures/invoice_items_100.csv',
                               :transactions => './test/fixtures/transaction_100.csv',
                               :customers => './data/customers.csv'})
    cr = se.customers
    customer = cr.find_by_id(1)

    assert_instance_of Array, customer.merchants
    assert_instance_of Merchant, customer.merchants.first
    assert_equal 8, customer.merchants.length
  end
end

