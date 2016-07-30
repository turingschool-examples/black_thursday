require './test/test_helper'
require './lib/customer'

class CustomerTest < Minitest::Test
  def test_it_has_appropriate_data
    c = Customer.new({
      :id => 1,
      :first_name => "Ghengis",
      :last_name => "Khan",
      :created_at => Time.now,
      :updated_at => Time.now
      })
    assert_equal 1, c.id
    assert_equal "Ghengis", c.first_name
    assert_equal "Khan", c.last_name
    assert_equal Time, c.created_at.class
    assert_equal Time, c.updated_at.class
  end

  def test_customer_has_merchant
    # mock_cr = Minitest::Mock.new
    # c = Customer.new({
    #   :id => 1,
    #   :first_name => "Ghengis",
    #   :last_name => "Khan",
    #   :created_at => Time.now,
    #   :updated_at => Time.now
    #   }, mock_cr)
    # mock_cr.
  end
end
