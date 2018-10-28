require './test/test_helper'
require './lib/customer_repository'
require './lib/customer'

class CustomerRepositoryTest < Minitest::Test
  def setup
    @customer_1 = Customer.new({id: 1, first_name: "John", last_name: "Oliver",
                  created_at: Time.now, updated_at: Time.now})
    @customer_2 = Customer.new({id: 2, first_name: "Alice", last_name: "Wonder",
                  created_at: Time.now, updated_at: Time.now})
    @customer_3 = Customer.new({id: 3, first_name: "John", last_name: "Wonder",
                  created_at: Time.now, updated_at: Time.now})
    @cr = CustomerRepository.new
    @cr.add_customer(@customer_1)
    @cr.add_customer(@customer_2)
    @cr.add_customer(@customer_3)
  end

  def test_it_exists
    assert_instance_of CustomerRepository, @cr
  end

  def test_it_returns_all
    expected = [@customer_1, @customer_2, @customer_3]
    assert_equal expected, @cr.all
  end

  def test_it_can_find_by_id
    assert_equal @customer_2, @cr.find_by_id(2)
    assert_nil @cr.find_by_id(50)
  end

  def test_it_can_find_all_by_first_name
    expected = [@customer_1, @customer_3]
    assert_equal expected, @cr.find_all_by_first_name("John")
    expected = []
    assert_equal expected, @cr.find_all_by_first_name("Cans")
  end

  def test_it_can_find_all_by_last_name
    expected = [@customer_2, @customer_3]
    assert_equal expected, @cr.find_all_by_last_name("Wonder")
    expected = []
    assert_equal expected, @cr.find_all_by_last_name("Soda")
  end

  def test_it_can_create_new_customer
    attributes = {first_name: "Ben", last_name: "Nodsel",
                  created_at: Time.now, updated_at: Time.now}
    @cr.create(attributes)
    assert_equal 4, @cr.all.last.id
    assert_equal "Ben", @cr.all.last.first_name
    assert_equal "Nodsel", @cr.all.last.last_name
    assert_instance_of Time, @cr.all.last.created_at
    assert_instance_of Time, @cr.all.last.updated_at
  end

  def test_it_can_update_name
    id = 2
    attributes = {first_name: "Mary", last_name: "Logger"}
    @cr.update(id, attributes)
    assert_equal "Mary", @cr.find_by_id(2).first_name
    assert_equal "Logger", @cr.find_by_id(2).last_name
  end

  def test_it_can_delete_customer
    @cr.delete(2)
    expected = [@customer_1, @customer_3]
    assert_equal expected, @cr.all
    assert_nil @cr.delete(50)
  end

end
