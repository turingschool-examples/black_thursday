require_relative 'test_helper'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < MiniTest::Test
  attr_reader :cr

  def setup
    @cr = CustomerRepository.new
    @cr.populate("./test/fixtures/customers_fixture.csv")
  end

  def test_existence
    assert_instance_of CustomerRepository, cr
  end

  def test_all_contains_all_customer_objects
    assert_instance_of Array, cr.all
    assert_instance_of Customer, cr.all.last
    assert_equal 4, cr.all.count
  end

  def test_can_find_customer_by_id
    assert_instance_of Customer, cr.find_by_id(4)
    assert_equal "Leanne", cr.find_by_id(4).first_name
    assert_nil cr.find_by_id(17)
  end

  def test_can_find_customer_by_first_name
    assert_instance_of Array, cr.find_all_by_first_name("Joey")
    assert_instance_of Customer, cr.find_all_by_first_name("Joey").first
    assert_equal [], cr.find_all_by_first_name("Lee")
  end

  def test_can_find_customer_by_last_name
    assert_instance_of Array, cr.find_all_by_last_name("Toy")
    assert_instance_of Customer, cr.find_all_by_last_name("Toy").first
    assert_equal [], cr.find_all_by_last_name("Lee")
  end

end
