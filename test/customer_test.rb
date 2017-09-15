require './test/test_helper'
require './lib/customer'

class CustomerTest < Minitest::Test
  attr_reader :customer
  def setup
    @customer = Customer.new({
                              :id => 6,
                              :first_name => "Joan",
                              :last_name => "Clarke",
                              :created_at => "2012-03-27 14:54:09 UTC",
                              :updated_at => "2012-03-27 14:54:09 UTC"
                              })
  end

  def test_that_it_exists
    assert_instance_of Customer, customer
  end

  def test_customer_has_an_id_value
    assert_equal 6, customer.id
    assert_instance_of Integer, customer.id
  end

  def test_customer_has_a_first_name_value
    assert_equal "Joan", customer.first_name
    assert_instance_of String, customer.first_name
  end

  def test_customer_has_a_last_name_value
    assert_equal "Clarke", customer.last_name
    assert_instance_of String, customer.last_name
  end

  def test_customer_has_a_created_at_value
    assert_instance_of Time, customer.created_at
  end

  def test_customer_has_a_updated_at_value
    assert_instance_of Time, customer.updated_at
  end

  def test_customer_has_a_parent_value
    assert_nil customer.parent
  end
end



# context "Customer" do
#   let(:customer) { engine.customers.find_by_id(500) }

#   it "#id returns the id" do
#     expect(customer.id).to eq 500
#     expect(customer.id.class).to eq Fixnum
#   end

#   it "#first_name returns the first_name" do
#     expect(customer.first_name).to eq "Hailey"
#     expect(customer.first_name.class).to eq String
#   end

#   it "#last_name returns the last_name" do
#     expect(customer.last_name).to eq "Veum"
#     expect(customer.last_name.class).to eq String
#   end

#   it "#created_at returns a Time instance for the date the invoice item was created" do
#     expect(customer.created_at).to eq Time.parse("2012-03-27 14:56:08 UTC")
#     expect(customer.created_at.class).to eq Time
#   end

#   it "#updated_at returns a Time instance for the date the invoice item was last updated" do
#     expect(customer.updated_at).to eq Time.parse("2012-03-27 14:56:08 UTC")
#     expect(customer.updated_at.class).to eq Time
#   end
# end