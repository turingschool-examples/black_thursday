require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/customer'

class CustomerTest < MiniTest::Test

  def setup
    Time.stubs(:now).returns(Time.new(1960, 12, 12))
    @time = Time.new(1960, 12, 12)
    @c = Customer.new({
      :id => 6,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => Time.now,
      :updated_at => Time.now
    }) 
  end

  def test_it_exists_with_attributes
    assert_instance_of Customer, @c
    assert_equal 6, @c.id
    assert_equal "Joan", @c.first_name
    assert_equal "Clarke", @c.last_name
    assert_equal @time, @c.created_at
    assert_equal @time, @c.updated_at
  end
end