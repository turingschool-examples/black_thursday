require_relative 'test_helper'
require_relative '../lib/customer'

class CustomerTest < Minitest::Test

  attr_reader :parent, :customer_1, :customer_2

  def setup
    @parent = Minitest::Mock.new
    @customer_1 = Customer.new({:id => '1',
                              :first_name => 'Joey',
                              :last_name => 'Ondricka',
                              :created_at => '2007-03-27 14:54:09 UTC', 
                              :updated_at => '2012-03-27 14:54:09 UTC'},
                              parent)
    @customer_2 = Customer.new({:id => '2',
                              :first_name => 'Cecelia',
                              :last_name => 'Osinski',
                              :created_at => '2012-03-27 14:54:10 UTC', 
                              :updated_at => '2015-03-27 14:54:10 UTC'},
                              parent)
  end

  def test_customers_have_idividual_ids
    assert_equal 1, customer_1.id
    assert_equal 2, customer_2.id
  end

  def test_customers_have_idividual_first_names
    assert_equal 'Joey', customer_1.first_name
    assert_equal 'Cecelia', customer_2.first_name
  end

  def test_customers_have_idividual_last_names
    assert_equal 'Ondricka', customer_1.last_name
    assert_equal 'Osinski', customer_2.last_name
  end

  def test_customers_have_idividual_dates_created_at
    assert_equal 2007, customer_1.created_at.year
    assert_equal 2012, customer_2.created_at.year
  end

  def test_customers_have_idividual_dates_updated_at
    assert_equal 2012, customer_1.updated_at.year
    assert_equal 2015, customer_2.updated_at.year
  end

end