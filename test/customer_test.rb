require_relative 'test_helper'
require_relative '../lib/customer'

class CustomerTest < Minitest::Test
  def setup
    customer = ({:id => "9", :first_name => "Loyal", :last_name => "Considine", :created_at => "2012-03-27 14:54:12 UTC", :updated_at => "2012-03-27 14:54:13 UTC"})
    Customer.new(customer, [])
  end

  def test_it_exists
    assert_instance_of Customer, setup
  end

  def test_it_returns_correct_id
    assert_equal 9, setup.id
  end

  def test_it_returns_correct_first_name
    assert_equal "Loyal", setup.first_name
  end

  def test_it_returns_correct_last_name
    assert_equal "Considine", setup.last_name
  end

  def test_time_returns_time_exists
    assert_instance_of Time, setup.created_at
    assert_instance_of Time, setup.updated_at
  end
end
