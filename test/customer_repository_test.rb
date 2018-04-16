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


end
