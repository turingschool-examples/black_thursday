require_relative 'test_helper'
require_relative '../lib/customer'

class MerchantTest < Minitest::Test
  def test_it_exists
    customer = Customer.new({:id => "9", :first_name => "Loyal", :last_name => "Considine", :created_at => "2012-03-27 14:54:12 UTC", :updated_at => "2012-03-27 14:54:13 UTC"})

    assert_instance_of Customer, customer
  end

  def test_it_returns_correct_id
    customer = Customer.new({:id => "9", :first_name => "Loyal", :last_name => "Considine", :created_at => "2012-03-27 14:54:12 UTC", :updated_at => "2012-03-27 14:54:13 UTC"})

    assert_equal 9, customer.id
  end

  def test_it_returns_correct_first_name
    customer = Customer.new({:id => "9", :first_name => "Loyal", :last_name => "Considine", :created_at => "2012-03-27 14:54:12 UTC", :updated_at => "2012-03-27 14:54:13 UTC"})

    assert_equal "Loyal", customer.first_name
  end

  def test_it_returns_correct_last_name
    customer = Customer.new({:id => "9", :first_name => "Loyal", :last_name => "Considine", :created_at => "2012-03-27 14:54:12 UTC", :updated_at => "2012-03-27 14:54:13 UTC"})

    assert_equal "Considine", customer.last_name
  end

  def test_time_returns_time_exists
    customer = Customer.new({:id => "9", :first_name => "Loyal", :last_name => "Considine", :created_at => "2012-03-27 14:54:12 UTC", :updated_at => "2012-03-27 14:54:13 UTC"})

    assert_instance_of Time, customer.created_at
    assert_instance_of Time, customer.updated_at
  end
end
