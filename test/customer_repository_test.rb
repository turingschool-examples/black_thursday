require_relative 'test_helper'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test
  attr_reader :cr

  def setup
    @cr = CustomerRepository.new
    cr.from_csv("./test/fixtures/customers_test.csv")
  end

  def test_it_exists
    assert_instance_of CustomerRepository, cr
  end

  def test_it_knows_all_instances_of_customer
    assert_instance_of Array, cr.all
    assert_equal 10, cr.all.count
    assert_instance_of Customer, cr.all.first
    assert_equal "Joey", cr.all.first.first_name
  end

  def test_it_can_find_by_id
    assert_instance_of Customer, cr.find_by_id(1)
    assert_equal "Ondricka", cr.find_by_id(1).last_name
    assert_nil cr.find_by_id(99)
  end

  def test_it_can_find_all_by_first_name
    assert_instance_of Array, cr.find_all_by_first_name("Dejon")
    assert_instance_of Customer, cr.find_all_by_first_name("Dejon").first
    assert_equal "Fadel", cr.find_all_by_first_name("Dejon").first.last_name
    assert_equal "Cecelia", cr.find_all_by_first_name("a").first.first_name
    assert_equal 6, cr.find_all_by_first_name("a").count
  end

  def test_it_can_find_all_by_first_name
    assert_instance_of Array, cr.find_all_by_last_name("Toy")
    assert_instance_of Customer, cr.find_all_by_last_name("Toy").first
    assert_equal "Mariah", cr.find_all_by_last_name("Toy").first.first_name
    assert_equal "Joey", cr.find_all_by_last_name("k").first.first_name
    assert_equal 3, cr.find_all_by_last_name("y").count
  end

end
