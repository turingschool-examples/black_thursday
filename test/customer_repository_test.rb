require 'test_helper'
require './lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test
  attr_reader :customers

  def setup
    parent = mock('parent')
    customers = [{
      :id => "112233",
      :first_name => "Max",
      :last_name => "Stackhouse",
      :created_at => '1990-07-18',
      :updated_at => '2017-11-03'},
      {
      :id => "223344",
      :first_name => "Nicholas",
      :last_name => "Mbogo",
      :created_at => '1988-09-28',
      :updated_at => '2017-11-03'
      }]
    @customers = CustomerRepository.new(customers, parent)
  end

  def test_it_initializes_with_attributes
    assert_instance_of CustomerRepository, customers
    assert_equal 2, customers.customers.count
    assert_instance_of Customer, customers.customers.first
    assert_instance_of Customer, customers.customers.last
    assert_instance_of CustomerRepository, customers.customers.first.parent
  end

end
