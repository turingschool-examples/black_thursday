require_relative 'test_helper'
require_relative '../lib/customer_repository'
require_relative '../lib/customer'

class CustomerRepositoryTest < Minitest::Test

  def setup
    @customer_1 = Customer.new({:id => 6, :first_name => "Joan", :last_name => "Clarke", :created_at => Time.now, :updated_at => Time.now})
    @customer_2 = Customer.new({:id => 33, :first_name => "Kat", :last_name => "Clarkson", :created_at => Time.now, :updated_at => Time.now})
    @customer_3 = Customer.new({:id => 12, :first_name => "Nick", :last_name => "Program", :created_at => Time.now, :updated_at => Time.now})
    @customer_4 = Customer.new({:id => 90, :first_name => "Nicolas", :last_name => "Jones", :created_at => Time.now, :updated_at => Time.now})
    @customers = [@customer_1, @customer_2, @customer_3, @customer_4]
    @customer_repository = CustomerRepository.new(@customers)
  end

  def test_it_exists
    assert_instance_of CustomerRepository, @customer_repository
  end

  def test_it_finds_all_instances
    assert_equal @customers, @customer_repository.all
  end

  def test_it_finds_by_id
    assert_equal @customer_2, @customer_repository.find_by_id(33)
    assert_equal nil, @customer_repository.find_by_id(687)
  end

  def test_it_finds_all_by_first_name
    expected = [@customer_3, @customer_4]
    assert_equal expected, @customer_repository.find_all_by_first_name("Nic")
    assert_equal [], @customer_repository.find_all_by_first_name("Ali")
  end

  def test_it_finds_all_by_last_name
    expected = [@customer_1, @customer_2]
    assert_equal expected, @customer_repository.find_all_by_last_name("Clar")
    assert_equal [], @customer_repository.find_all_by_last_name("Brow")
  end

  def test_it_can_create_new_customer
    assert_equal 4, @customer_repository.all.count
    @customer_repository.create({:first_name => "Nichole", :last_name => "Jonney", :created_at => Time.now, :updated_at => Time.now})

    assert_equal 5, @customer_repository.all.count
    assert_equal 91, @customer_repository.all.last.id
  end

  def test_it_can_update_existing_customer
    original_time = @customer_3.updated_at
    @customer_repository.update(12, {:first_name => "Nicholas", :last_name => "Programmer", :updated_at => Time.now})
    assert original_time < @customer_3.updated_at
    assert_equal "Nicholas", @customer_repository.find_by_id(12).first_name
    assert_equal "Programmer", @customer_repository.find_by_id(12).last_name
  end
end
