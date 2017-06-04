require_relative 'test_helper'
require_relative '../lib/customer'
require 'pry'

class CustomerTest < Minitest::Test

  attr_reader :customer

  def setup
    @customer = Customer.new({ :id => 6,
                               :first_name => "Joan",
                               :last_name  => "Clarke",
                               :created_at => "2012-03-27 14:56:10 UTC",
                               :updated_at => "2012-03-27 14:56:10 UTC" },
                               self)
  end

  def test_new_instance

    assert_instance_of Customer, customer
  end

  def test_id

    assert_equal 6, customer.id
  end

  def test_first_name

    assert_equal "Joan", customer.first_name
  end

  def test_last_name

    assert_equal "Clarke", customer.last_name
  end

  def test_created_at

    assert_instance_of Time, customer.created_at
  end

  def test_updated_at

    assert_instance_of Time, customer.created_at
  end


end
