require_relative './test_helper'

class CustomerTest < Minitest::Test
  def test_it_exists
    c = Customer.new({
    :id => 6,
    :first_name => "Joan",
    :last_name => "Clarke",
    :created_at => Time.now,
    :updated_at => Time.now
    })

    assert_instance_of Customer, c
  end

  def test_it_has_attributes
    c = Customer.new({
    :id => 6,
    :first_name => "Joan",
    :last_name => "Clarke",
    :created_at => "2016-01-11 12:29:33 UTC",
    :updated_at => "2018-01-11 12:29:33 UTC"
    })

    assert_equal 6,c.id
    assert_equal "Joan", c.first_name
    assert_equal "Clarke", c.last_name
    assert_equal Time.parse("2016-01-11 12:29:33 UTC"), c.created_at
    assert_equal Time.parse("2018-01-11 12:29:33 UTC"), c.updated_at
  end
end
