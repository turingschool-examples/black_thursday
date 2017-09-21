require "./test/test_helper"
require "./lib/customer"

class CustomerTest < Minitest::Test

  attr_reader :customer

  def setup
    csv_hash = {:id => 6,
                :first_name => "Joan",
                :last_name => "Clarke",
                :created_at => "2016-01-11 09:34:06 UTC",
                :updated_at => "2007-06-04 21:35:10 UTC"
               }
    @customer = Customer.new('fake_customer_repository', csv_hash)
  end

  def test_customer_exists
    assert_instance_of Customer, customer
  end

  def test_customer_has_id
    assert_equal 6, customer.id
  end

  def test_customer_has_first_name
    assert_equal "Joan", customer.first_name
  end

  def test_customer_has_last_name
    assert_equal "Clarke", customer.last_name
  end

  def test_customer_has_created_at_time
    assert_equal Time.parse("2016-01-11 09:34:06 UTC"), customer.created_at
  end

  def test_customer_has_updated_at_time
    assert_equal Time.parse("2007-06-04 21:35:10 UTC"), customer.updated_at
  end

end
