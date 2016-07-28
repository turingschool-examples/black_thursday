require './test/test_helper'
require './lib/sales_engine'

class CustomerTest < Minitest::Test

  def test_that_it_has_an_id
    customer = Customer.new({ id: 12, first_name: "Claude", last_name: "Montgomery", created_at: "2016-07-26 02:23:16 UTC", updated_at: "1970-04-01 12:45:13 UTC" })

    assert_equal 12, customer.id
  end

  def test_that_it_has_a_first_name
    customer = Customer.new({ id: 12, first_name: "Claude", last_name: "Montgomery", created_at: "2016-07-26 02:23:16 UTC", updated_at: "1970-04-01 12:45:13 UTC" })

    assert_equal "Claude", customer.first_name
  end

  def test_that_it_has_a_last_name
    customer = Customer.new({ id: 12, first_name: "Claude", last_name: "Montgomery", created_at: "2016-07-26 02:23:16 UTC", updated_at: "1970-04-01 12:45:13 UTC" })

    assert_equal "Montgomery", customer.last_name
  end

  def test_that_it_finds_when_created
    customer = Customer.new({ id: 12, first_name: "Claude", last_name: "Montgomery", created_at: "2016-07-26 02:23:16 UTC", updated_at: "1970-04-01 12:45:13 UTC" })

    assert_equal Time.new(2016, 07, 26, 02, 23, 16, "-00:00"), customer.created_at
  end

  def test_that_it_finds_when_updated
    customer = Customer.new({ id: 12, first_name: "Claude", last_name: "Montgomery", created_at: "2016-07-26 02:23:16 UTC", updated_at: "1970-04-01 12:45:13 UTC" })

    assert_equal Time.new(1970, 04, 01, 12, 45, 13, "-00:00"), customer.updated_at
  end

end
