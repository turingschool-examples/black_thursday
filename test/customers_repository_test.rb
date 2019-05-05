# frozen_string_literal: true

require 'simplecov'
SimpleCov.start
require 'minitest'
require 'minitest/emoji'
require 'minitest/autorun'
require './lib/customer_repository.rb'
require './lib/sales_engine.rb'

# Tests the functionality of the customer repository.
class CustomerRepositoryTest < MiniTest::Test
  def setup
    se = SalesEngine.from_csv({:customers => './fixtures/customers_test.csv'})
    @c = se.customers
  end

  def test_it_exists
    assert_instance_of CustomerRepository, @c
  end

  def test_it_returns_all_customers
    expected = 10
    actual = @c.all.length

    assert_equal expected, actual
  end

  def test_it_can_find_by_id
    expected = 2
    actual = @c.find_by_id(2).id

    assert_equal expected, actual
  end

  def test_it_can_find_all_by_first_name
    expected = 'Mariah'
    actual = @c.find_all_by_first_name('Maria').first.first_name

    assert_equal expected, actual
  end

  def test_it_can_find_all_with_fragment_first_name
    expected = 3
    actual = @c.find_all_by_first_name('er').length

    assert_equal expected, actual
  end

  def test_it_can_find_all_by_last_name_fragment
    expected = 3
    actual = @c.find_all_by_last_name('u').length

    assert_equal expected, actual
  end

  def test_it_can_create_a_new_customer
    expected = 11
    @c.create({first_name: "Olivia", last_name: "Newton"})
    actual = @c.find_by_id(11).id

    assert_equal expected, actual

    expected = "Olivia"
    actual = @c.find_by_id(11).first_name

    assert_equal expected, actual
  end

  def test_it_can_update_a_customer
    expected = "Kendrick"
    @c.update(5, {first_name: "Kendrick"})
    actual = @c.find_by_id(5).first_name

    assert_equal expected, actual
  end

  def test_it_can_delete_a_customer
    @c.delete(5)
    actual = @c.find_by_id(5)

    assert_nil actual
  end
end
