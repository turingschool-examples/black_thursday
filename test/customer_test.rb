require "minitest/autorun"
require "minitest/pride"
require "./lib/customer"
require "simplecov"

SimpleCov.start

class CustomerTest < Minitest::Test
  attr_reader :c
  def setup
    @c = Customer.new({
      :id => 6,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => "2012-03-27 14:54:09 UTC",
      :updated_at => "2013-03-27 14:54:09 UTC"
      })
  end

def test_it_exists
    assert_instance_of Customer, c
  end

  def test_it_knows_its_id
    assert_equal 6, c.id  
  end

  def test_it_knows_its_first_name
    assert_equal "Joan", c.first_name
  end

  def test_it_knows_its_last_name
    assert_equal "Clarke", c.last_name
  end

  def test_it_knows_date_created_at
    assert_instance_of Time, c.created_at
    assert_equal "2012-03-27 14:54:09 UTC", c.created_at.to_s
  end
  
  def test_it_knows_date_updated_at
    assert_instance_of Time, c.updated_at
    assert_equal "2013-03-27 14:54:09 UTC", c.updated_at.to_s
  end

end

