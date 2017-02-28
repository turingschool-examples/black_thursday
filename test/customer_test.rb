require './test/test_helper'

class CustomerTest < Minitest::Test

attr_reader :customer

  def setup
    @customer = Customer.new({ id:"1",
                               first_name: "Joey",
                               last_name: "Ondricka",
                               created_at: "2012-03-27 14:54:09 UTC",
                               updated_at: "2012-03-27 14:54:09 UTC"})
  end

  def test_it_has_id
    assert_equal 1, customer.id
  end

  def test_it_has_first_name
    assert_equal "Joey", customer.first_name
  end

  def test_it_has_last_name
    assert_equal "Ondricka", customer.last_name
  end

  def test_created_time
    assert_equal Time.parse("2012-03-27 14:54:09 UTC"), customer.created_at
  end

  def test_updated_time
    assert_equal Time.parse("2012-03-27 14:54:09 UTC"), customer.updated_at
  end

end
