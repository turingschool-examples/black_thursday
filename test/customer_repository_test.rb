require_relative 'test_helper'
require_relative '../lib/customer_repository'
require_relative '../lib/customer'

class CustomerRepositoryTest < Minitest::Test

  def setup
    @customer_1 = Customer.new({:id => 6, :first_name => "Joan", :last_name => "Clarke", :created_at => Time.now, :updated_at => Time.now})
    @customer_2 = Customer.new({:id => 33, :first_name => "Kat", :last_name => "Computer", :created_at => Time.now, :updated_at => Time.now})
    @customer_3 = Customer.new({:id => 12, :first_name => "Nick", :last_name => "Program", :created_at => Time.now, :updated_at => Time.now})
    @customer_4 = Customer.new({:id => 90, :first_name => "Bob", :last_name => "Jones", :created_at => Time.now, :updated_at => Time.now})
    @customers = [@customer_1, @customer_2, @customer_3, @customer_4]
    @customer_repository = CustomerRepository.new(@customers)
  end

  def test_it_exists
    assert_instance_of CustomerRepository, @customer_repository
  end

  def test_it_finds_all_instances
    assert_equal @customers, @customer_repository.all
  end

end
