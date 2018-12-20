# frozen_string_literal: true

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
    actual = @cr.create(id: 7, first_name: 'Wes', last_name: 'Anderson', created_at: Time.now, updated_at: Time.now)

    assert_instance_of Customer, actual
  end

  def test_it_returns_array_of_all_customers
    customer_list = @cr.create(id: 7, first_name: 'Wes', last_name: 'Anderson', created_at: '2007-06-08', updated_at: '2009-05-30'),
                    @cr.create(id: 8, first_name: 'Quentin', last_name: 'Tarantino', created_at: '2007-06-08', updated_at: '2011-08-20')

    assert_equal [customer_list].flatten, @cr.all
  end

  def test_it_can_find_by_id
    expected = @cr.create(id: 7, first_name: 'Wes', last_name: 'Anderson', created_at: Time.now, updated_at: Time.now)

    assert_equal expected, @cr.find_by_id(7)
  end

  def test_it_can_find_by_all_first_name
    created1 = @cr.create(id: 7, first_name: 'Wes', last_name: 'Anderson', created_at: Time.now, updated_at: Time.now)
    created2 = @cr.create(id: 8, first_name: 'Wes', last_name: 'Mcfly', created_at: Time.now, updated_at: Time.now)
    @cr.create(id: 9, first_name: 'Napoleon', last_name: 'Winter', created_at: Time.now, updated_at: Time.now)

    expected = [created1, created2]

    assert_equal expected, @cr.find_all_by_first_name('Wes')
  end

  def test_it_can_find_all_by_last_name
    created1 = @cr.create(id: 7, first_name: 'Wes', last_name: 'Anderson', created_at: Time.now, updated_at: Time.now)
    created2 = @cr.create(id: 8, first_name: 'Neo', last_name: 'Anderson', created_at: Time.now, updated_at: Time.now)
    @cr.create(id: 9, first_name: 'Napoleon', last_name: 'Winter', created_at: Time.now, updated_at: Time.now)

    expected = [created1, created2]

    assert_equal expected, @cr.find_all_by_last_name('Anderson')
  end

  def test_it_can_update_a_customer_first_name

    @cr.create(id: 7, first_name: 'Wes', last_name: 'Anderson', created_at: Time.now, updated_at: Time.now)

    @cr.update(7, first_name: 'Alexandre', last_name: 'Anderson', created_at: Time.now, updated_at: Time.now)
    assert_equal 'Alexandre', @cr.find_by_id(7).first_name
  end

  def test_it_can_update_a_customer_last_name
    @cr.create(id: 7, first_name: 'Wes', last_name: 'Anderson', created_at: Time.now, updated_at: Time.now)
    @cr.update(7, first_name: 'Wes', last_name: 'Snipes', created_at: Time.now, updated_at: Time.now)

    assert_equal 'Snipes', @cr.find_by_id(7).last_name
  end

  def test_it_can_delete_customer_by_id
    created = @cr.create(id: 7, first_name: 'Wes', last_name: 'Anderson', created_at: Time.now, updated_at: Time.now)

    assert_equal created, @cr.delete(7)
    assert_equal [], @cr.all
  end
end
