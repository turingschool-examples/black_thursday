require_relative './test_helper'
require_relative '../lib/customer'

class CustomerTest < Minitest::Test

  def setup
    @created_at_time = Time.parse("2012-03-27 14:54:09 UTC")
    @updated_at_time = Time.parse("2012-03-27 14:54:09 UTC")
    @customer1 = Customer.new({
      :id => 1,
      :first_name => "Joey",
      :last_name => "Ondricka",
      :created_at => @created_at_time,
      :updated_at => @updated_at_time
      })
  end

  def test_it_exists
      assert_instance_of Customer, @customer1
  end

  def test_has_attributes
    assert_equal 1, @customer1.id
    assert_equal "Joey", @customer1.first_name
    assert_equal "Ondricka", @customer1.last_name
    assert_equal @created_at_time, @customer1.created_at
    assert_equal @updated_at_time, @customer1.updated_at
    assert_equal "Joey Ondricka", @customer1.whole_name
  end

end
