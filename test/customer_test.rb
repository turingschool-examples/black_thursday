
require_relative 'test_helper'

require 'time'

require_relative '../lib/customer'


class CustomerTest < Minitest::Test

  def setup
    hash = {
              :id                          => "1",
              :first_name                  => "Joey",
              :last_name                   => "Ondricka",
              :created_at                  => "2012-03-27 14:54:09 UTC",
              :updated_at                  => "2012-03-27 14:54:09 UTC"
    }
    @customer = Customer.new(hash)
  end

  def test_it_exists
    assert_instance_of Customer, @customer
  end

  def test_it_gets_attributes
    assert_equal 1, @customer.id
    assert_equal "Joey", @customer.first_name
    assert_equal "Ondricka", @customer.last_name
    assert_instance_of Time, @customer.created_at
    assert_equal "2012-03-27 14:54:09 UTC", @customer.created_at.to_s
    assert_instance_of Time, @customer.updated_at
    assert_equal "2012-03-27 14:54:09 UTC", @customer.updated_at.to_s
  end

  def test_it_can_make_an_update
    now = Time.now
    hash = {
              :id                          => "NOPE",
              :created_at                  => "NOPE",
              :first_name                  => "YES",
              :last_name                   => "YES",
              :updated_at                  => now
    }
    @customer.make_update(hash)
    # --- denied ---
    refute_equal "NOPE", @customer.id
    refute_equal "NOPE", @customer.created_at
    # --- allowed ---
    assert_equal "YES", @customer.first_name
    assert_equal "YES", @customer.last_name
    assert_equal now.to_s, @customer.updated_at.to_s
  end

end
