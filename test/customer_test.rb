require_relative 'test_helper'
require_relative '../lib/customer'
require 'bigdecimal'
require 'time'

class CustomerTest < Minitest::Test
  attr_reader :customer1,
              :customer2,
              :customer3,
              :customer4
  def setup
    customer_info_1 = ({
      :id          => "5",
      :first_name  => "Joan",
      :last_name   => "Clarke",
      :created_at  => "2016-11-01 11:38:28 -0600",
      :updated_at  => "2016-11-01 14:38:28 -0600",
    })
    customer_info_2 = ({
      :id          => nil,
      :first_name  => nil,
      :last_name   => nil,
      :created_at  => "2016-11-01 11:38:28 -0600",
      :updated_at  => "2016-11-01 14:38:28 -0600",
    })
    parent = Minitest::Mock.new
    @customer1 = Customer.new(customer_info_1, parent)
    @customer2 = Customer.new(customer_info_2, parent)
    @customer3 = Customer.new()
    @customer4 = Customer.new({})
  end

  def test_it_exists
    assert customer1
  end

  def test_it_initializes_customer_id
    assert_equal 5, customer1.id
  end

  def test_it_initializes_customer_first_name
    assert_equal "Joan", customer1.first_name
  end

  def test_it_initializes_customer_last_name
    expected = "Clarke"
    assert_equal expected, customer1.last_name
  end

  def test_it_initializes_customer_create_time
    expected = Time.parse("2016-11-01 11:38:28 -0600")
    assert_equal expected, customer1.created_at
  end

  def test_it_initializes_customer_update_time
    expected = Time.parse("2016-11-01 14:38:28 -0600")
    assert_equal expected, customer1.updated_at
  end

  def test_it_initializes_customer_id
    assert_equal 5, customer1.id
  end

  def test_it_returns_zero_if_there_is_no_id_given
    assert_equal 0, customer2.id
  end

  def test_it_returns_empty_string_if_there_is_no_fist_name_given
    assert_equal "", customer2.first_name
  end

  def test_it_returns_empty_string_if_there_is_no_last_name_given
    assert_equal "", customer2.last_name
  end

  def test_it_returns_blank_customer_object_if_no_data_passed
    assert_equal Customer, customer3.class
    assert_nil customer3.id
    assert_nil customer3.created_at
    assert_nil customer3.last_name
  end

  def test_it_returns_blank_customer_object_if_empty_hash_passed
    assert_equal Customer, customer4.class
    assert_nil customer4.first_name
    assert_nil customer4.last_name
    assert_nil customer4.updated_at
  end

end
