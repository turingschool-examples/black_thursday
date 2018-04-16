require 'minitest/autorun'
require 'time'
require 'minitest/pride'
require './lib/customer'

class CustomerTest < Minitest::Test

  def setup
    @time = "2016-01-11 09:34:06 UTC"
    @customer = Customer.new({
      :id                           => "1",
      :first_name                   => "Joey",
      :last_name                    => "Ondricka",
      :created_at                   => @time,
      :updated_at                   => @time
    })
  end

  def test_it_exists
    assert_instance_of Customer, @customer
  end

  def test_it_has_attributes
    assert_equal 1, @customer.id
    assert_equal "Joey", @customer.first_name
    assert_equal "Ondricka", @customer.last_name
    assert_equal @time, @customer.created_at
    assert_equal @time, @customer.updated_at
  end

end
