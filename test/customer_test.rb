require_relative 'test_helper'
require_relative '../lib/customer'
require 'pry'

class CustomerTest < Minitest::Test

  attr_reader :customer

  def setup
    @customer = Customer.new({ :id => 6,
                              :first_name => "Joan",
                              :last_name  => "Clarke",
                              :created_at => Time.now,
                              :updated_at => Time.now },
                              self)
  end

  def test_new_instance

   assert_instance_of Customer, customer
 end


end
