require_relative '../lib/customer'
require_relative '../test/test_helper'

class CustomerTest < Minitest::Test

  def test_it_exists
    parent = mock("parent")
    customer = Customer.new({ :id         => "6",
                              :first_name => "Joan",
                              :last_name  => "Clarke",
                              :created_at => Time.now,
                              :updated_at => Time.now },
                              parent)

    assert_instance_of Customer, customer
  end

  def test_it_has_id
    parent = mock("parent")
    customer = Customer.new({ :id         => "6",
                              :first_name => "Joan",
                              :last_name  => "Clarke",
                              :created_at => Time.now,
                              :updated_at => Time.now },
                              parent)

    assert_equal 6, customer.id
  end

  def test_it_has_first_name
    parent = mock("parent")
    customer = Customer.new({ :id         => "6",
                              :first_name => "Joan",
                              :last_name  => "Clarke",
                              :created_at => Time.now,
                              :updated_at => Time.now },
                              parent)

    assert_equal "Joan", customer.first_name
  end

  def test_it_has_last_name
    parent = mock("parent")
    customer = Customer.new({ :id         => "6",
                              :first_name => "Joan",
                              :last_name  => "Clarke",
                              :created_at => Time.now,
                              :updated_at => Time.now },
                              parent)

    assert_equal "Clarke", customer.last_name
  end

  def test_it_has_created_at
    parent = mock("parent")
    customer = Customer.new({ :id         => "6",
                              :first_name => "Joan",
                              :last_name  => "Clarke",
                              :created_at => "2012-03-27 14:54:09 UTC",
                              :updated_at => "2012-05-01 16:12:02 UTC" },
                              parent)

    assert_equal Time.parse("2012-03-27 14:54:09 UTC"), customer.created_at
  end

  def test_it_has_updated_at
    parent = mock("parent")
    customer = Customer.new({ :id         => "6",
                              :first_name => "Joan",
                              :last_name  => "Clarke",
                              :created_at => "2012-03-27 14:54:09 UTC",
                              :updated_at => "2012-05-01 16:12:02 UTC" },
                              parent)

    assert_equal Time.parse("2012-05-01 16:12:02 UTC"), customer.updated_at
  end

end
