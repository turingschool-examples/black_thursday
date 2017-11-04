require_relative "test_helper"
require './lib/customer'

class CustomerTest < Minitest::Test
  def test_it_initializes_with_attributes
    parent = mock('parent')
    customer = Customer.new({
      :id => "112233",
      :first_name => "Max",
      :last_name => "Stackhouse",
      :created_at => '1990-07-18',
      :updated_at => '2017-11-03'
      }, parent)

    assert_instance_of Customer, customer
    assert_equal 112233, customer.id
    assert_equal "Max", customer.first_name
    assert_equal "Stackhouse", customer.last_name
    assert_equal Time.parse('1990-07-18'), customer.created_at
    assert_equal Time.parse('2017-11-03'), customer.updated_at
    assert customer.parent
  end

  def test_it_initializes_with_other_attributes
    parent = mock('parent')
    customer = Customer.new({
      :id => "223344",
      :first_name => "Nicholas",
      :last_name => "Mbogo",
      :created_at => '1988-09-28',
      :updated_at => '2017-11-03'
      }, parent)

    assert_instance_of Customer, customer
    assert_equal 223344, customer.id
    assert_equal "Nicholas", customer.first_name
    assert_equal "Mbogo", customer.last_name
    assert_equal Time.parse('1988-09-28'), customer.created_at
    assert_equal Time.parse('2017-11-03'), customer.updated_at
    assert customer.parent
  end

  def test_it_can_use_merchants
    parent = mock('parent')
    customer = Customer.new({
      :id => "112233",
      :first_name => "Max",
      :last_name => "Stackhouse",
      :created_at => '1990-07-18',
      :updated_at => '2017-11-03'
      }, parent)
    parent.stubs(:find_by_customer_id).with(112233).returns(true)

    assert customer.merchants
  end
end
