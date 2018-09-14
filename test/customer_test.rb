require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/customer'


class CustomerTest < Minitest::Test

  def setup
    @hash = {
              :id                          => 1,
              :first_name                  => "Joey",
              :last_name                   => "Ondricka",
              :created_at                  => "2012-03-27 14:54:09 UTC",
              :updated_at                  => "2012-03-27 14:54:09 UTC"
    }
    @c = Customer.new(@hash)
  end

  def test_it_exists
    assert_instance_of Customer, @c
  end

  def test_it_gets_attributes
    assert_equal 1, @c.id
    assert_equal "Joey", @c.first_name
    assert_equal "Ondricka", @c.last_name
    assert_equal "2012-03-27 14:54:09 UTC", @c.created_at
    assert_equal "2012-03-27 14:54:09 UTC", @c.updated_at
  end

end
