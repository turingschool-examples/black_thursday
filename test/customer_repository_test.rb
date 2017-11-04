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
      :updated_at => '2017-11-03'
      },{
      :id => "789987",
      :first_name => "Max",
      :last_name => "Payne",
      :created_at => '1963-10-13',
      :updated_at => '2017-11-11'
      },{
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
    assert_equal 3, customers.all.count
    assert_instance_of Customer, customers.all.first
    assert_instance_of Customer, customers.all.last
    assert_instance_of CustomerRepository, customers.all.first.parent
  end

  def test_find_by_id
    assert_instance_of Customer, customers.find_by_id(112233)
    assert_equal "Max", customers.find_by_id(112233).first_name
    assert_nil customers.find_by_id(123456)
  end

  def test_find_all_by_first_name
    all_max = customers.find_all_by_first_name("Max")

    assert_equal 2, all_max.count
    assert_instance_of Customer, all_max.first
    assert_equal "Max", all_max.first_name.first.first_name
    assert_equal "Max", all_max.first_name.last.first_name
  end

  def test_find_all_by_last_name
    all_payne = customers.find_all_by_last_name("Payne")

    assert_equal 1, all_payne.count
    assert_instance_of Customer, all_payne.first
    assert_equal "Payne", all_payne.first.first_name
  end
end
