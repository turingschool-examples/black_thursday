require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer.rb'

class CustomerTest < Minitest::Test
  def setup
    @c = Customer.new({
      :id => 6,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => Time.now,
      :updated_at => Time.now
      } )
  end
  def test_it_exists
    assert_instance_of Customer, @c
  end


end
