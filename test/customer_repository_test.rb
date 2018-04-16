require 'minitest/autorun'
require 'time'
require 'minitest/pride'
require './lib/customer_repository'
require 'pry'

class CustomerRepositoryTest < Minitest::Test

  def setup
    @customer1 = [
      [:id, '4'],
      [:first_name, 'Leanne'],
      [:last_name, 'Braun'],
      [:created_at, '2012-03-27 14:54:10 UTC'],
      [:updated_at, '2012-03-27 14:54:10 UTC']
      ]
    @customer2 = [
      [:id, '35'],
      [:first_name, 'Pamela'],
      [:last_name, 'Gulgowski'],
      [:created_at, '2012-03-27 14:54:18 UTC'],
      [:updated_at, '2012-03-27 14:54:18 UTC']
      ]
    @customer3 = [
      [:id, '140'],
      [:first_name, 'Vladimir'],
      [:last_name, 'Crist'],
      [:created_at, '2012-03-27 14:54:43 UTC'],
      [:updated_at, '2012-03-27 14:54:43 UTC']
      ]
    @customers = [@customer1, @customer2, @customer3]
    @cr = CustomerRepository.new(@customers)
  end

  def test_it_exists
      assert_instance_of CustomerRepository, @cr
  end

  def test_it_holds_customers
    @cr.repository.values.all? do |customer|
      assert_instance_of Customer, customer
    end
    assert_instance_of Customer, @cr.repository.values[0]
    assert_instance_of Customer, @cr.repository.values[1]
  end

  def test_all_returns_all_customers
    @cr.all.all? do |customer|
      assert_instance_of Customer, customer
    end
  end

  def test_can_find_by_id
    actual = @cr.find_by_id(4)
    assert_equal 'Braun', actual.last_name

    actual = @cr.find_by_id(35)
    assert_equal 'Pamela', actual.first_name

    actual = @cr.find_by_id(140)
    assert_instance_of Time, actual.created_at
  end

  def test_can_find_all_by_first_name
    actual = @cr.find_all_by_first_name('Leanne')
    assert_equal 'Braun', actual[0].last_name

    actual = @cr.find_all_by_first_name('Pamela')
    assert_equal 35, actual[0].id

    actual = @cr.find_all_by_first_name('Vladimir')
    assert_instance_of Time, actual[0].updated_at
  end

  def test_can_find_all_by_last_name
    actual = @cr.find_all_by_last_name('Gulgowski')
    assert_equal 35, actual[0].id

    actual = @cr.find_all_by_last_name('Crist')
    assert_equal 'Vladimir', actual[0].first_name

    actual = @cr.find_all_by_last_name('Braun')
    assert_instance_of Time, actual[0].created_at
  end


end
