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
require './lib/transaction'
require './lib/transaction_repo'
require './lib/customer'
require './lib/customer_repo'

class CustomerTest < MiniTest::Test

  def test_it_exists
    se = SalesEngine.from_csv({:customer => "./data/customer.csv"})
    c = Customer.new({
                      :id => 6,
                      :first_name => "Joan",
                      :last_name => "Clarke",
                      :created_at => Time.now,
                      :updated_at => Time.now
                    }, self)
    assert_instance_of Customer, c
  end

  def test_customer_attributes
    c = Customer.new({
                      :id => 6,
                      :first_name => "Joan",
                      :last_name => "Clarke",
                      :created_at => Time.now,
                      :updated_at => Time.now
                    }, self)

    assert_equal 6, c.id
    assert_equal "Joan", c.first_name
    assert_equal "Clarke", c.last_name
    assert_instance_of Time, c.created_at
    assert_instance_of Time, c.updated_at
  end
end
