require_relative 'test_helper'
require_relative '../lib/customer_repository'
require_relative '../lib/customer'

class CustomerRepositoryTest < Minitest::Test 
  attr_reader :customer_repo
  def setup 
    @customer_repo = CustomerRepository.new('data/customers.csv')
  end
  
  def test_it_exists 
    assert_instance_of CustomerRepository, customer_repo
  end
end

# it "#all returns all of the customers" do
#   expected = engine.customers.all
#   expect(expected.length).to eq 1000
#   expect(expected.first.class).to eq Customer
# end

# it "#find_by_id returns the customer with matching id" do
#   id = 100
#   expected = engine.customers.find_by_id(id)

#   expect(expected.id).to eq id
#   expect(expected.class).to eq Customer
# end

# it "#find_all_by_first_name returns all customers with matching first name" do
#   fragment = "oe"
#   expected = engine.customers.find_all_by_first_name(fragment)

#   expect(expected.length).to eq 8
#   expect(expected.first.class).to eq Customer
# end

# it "#find_all_by_last_name returns all customers with matching last name" do
#   fragment = "On"
#   expected = engine.customers.find_all_by_last_name(fragment)

#   expect(expected.length).to eq 85
#   expect(expected.first.class).to eq Customer
# end

# it "#find_all_by_first_name and #find_all_by_last_name are case insensitive" do
#   fragment = "NN"
#   expected = engine.customers.find_all_by_first_name(fragment)

#   expect(expected.length).to eq 57
#   expect(expected.first.class).to eq Customer

#   fragment = "oN"
#   expected = engine.customers.find_all_by_last_name(fragment)

#   expect(expected.length).to eq 85
#   expect(expected.first.class).to eq Customer
# end