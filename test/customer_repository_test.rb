require './lib/customer_repository'
require './lib/customer'
require 'bigdecimal'
require './test/test_helper'

class CustomerRepositoryTest < Minitest::Test
  def setup
    @now = Time.now
    @cr = CustomerRepository.new

    @c_1 = {
      :id => 6,
      :first_name => "Clark",
      :last_name => "Kent",
      :created_at => @now,
      :updated_at => @now
    }

    @c_2 = {
      :id => 6,
      :first_name => "Joan",
      :last_name => "Clarkeson",
      :created_at => @now,
      :updated_at => @now
    }

    @c_3 = {
      :id => 6,
      :first_name => "Joshua",
      :last_name => "Kent",
      :created_at => @now,
      :updated_at => @now
    }
  end

  def create_customers
    @cr.create(@c_1)
    @cr.create(@c_2)
    @cr.create(@c_3)
  end

  def test_it_exists
    assert_instance_of CustomerRepository, @cr
  end

  def test_it_has_a_type
    assert_equal Customer, @cr.type
  end

  def test_it_has_an_attr_whitelist
    assert_equal [:first_name, :last_name], @cr.attr_whitelist
  end

  def test_find_all_by_first_name_returns_empty_array_if_no_matches
    create_customers

    assert_equal [], @cr.find_all_by_first_name("Robert")
  end

  def test_find_all_by_first_name_returns_matching_customers
    create_customers

    expected = [Customer.new(@c_1)]
    result = @cr.find_all_by_first_name("Clark")

    assert_equal expected, result
  end

  def test_find_all_by_last_name_returns_empty_array_if_no_matches
    create_customers

    assert_equal [], @cr.find_all_by_last_name("Wilson")
  end

  def test_find_all_by_last_name_returns_matching_customers
    create_customers

    expected = [Customer.new(@c_1), Customer.new(@c_3)]
    result = @cr.find_all_by_last_name("Kent")

    assert_equal expected, result
  end
end
