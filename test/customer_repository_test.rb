#frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'

require './lib/customer_repository'

# Customer repository test class
class CustomerRepositoryTest < Minitest::Test
  def setup
    @cr = CustomerRepository.new
  end

  def test_it_exists
    assert_instance_of CustomerRepository, @cr
  end

  def test_it_can_create_a_customer_instance
    actual = @cr.create(id: 7, first_name: "Wes", last_name: "Anderson")

    assert_instance_of Customer, actual
  end

  def test_it_returns_array_of_all_customers
    customer_list = @cr.create(id: 7, first_name: "Wes", last_name: "Anderson", updated_at: '2009-05-30'),
                    @cr.create(id: 8, first_name: "Quentin", last_name: "Tarantino", updated_at: '2011-08-20')

    assert_equal [customer_list].flatten, @cr.all
  end

  def test_it_can_find_by_id
    expected = @cr.create(id: 7, first_name: "Wes", last_name: "Anderson")

    assert_equal expected, @cr.find_by_id(7)
  end

  def test_it_can_find_by_all_first_name
    created1 = @cr.create(id: 7, first_name: "Wes", last_name: "Anderson")
    created2 = @cr.create(id: 8, first_name: "Wes", last_name: "Mcfly")
    created3 = @cr.create(id: 9, first_name: "Napoleon", last_name: "Winter")

    expected = [created1, created2]

    assert_equal expected, @cr.find_all_by_first_name("Wes")
  end

  def test_it_can_find_all_by_last_name
    created1 = @cr.create(id: 7, first_name: "Wes", last_name: "Anderson")
    created2 = @cr.create(id: 8, first_name: "Neo", last_name: "Anderson")
    created3 = @cr.create(id: 9, first_name: "Napoleon", last_name: "Winter")

    expected = [created1, created2]

    assert_equal expected, @cr.find_all_by_last_name("Anderson")
  end

  def test_it_can_update_a_customer_first_name
    @cr.create(id: 7, first_name: "Wes", last_name: "Anderson")

    expected = @cr.update(first_name: "Alexandre", last_name: "Anderson")
    actual   = @cr.find_by_first_name(id: 7, first_name: "Alexandre", last_name: "Anderson")
#what is the best way to test this?
    assert_equal expected, actual
  end



end
