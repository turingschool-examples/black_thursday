require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer'
require_relative '../lib/customer_repo'

class CustomerTest < Minitest::Test
  attr_reader :data,
              :repo

  def setup
    @data = Customer.new({:id => 6,
                          :first_name => "Joan",
                          :last_name => "Clarke",
                          :created_at => Time.now,
                          :updated_at => Time.now})
    @repo = Minitest::Mock.new
  end

  def test_it_exists
    assert Customer.new(data, repo)
  end

  def test_it_has_a_class
    c = Customer.new(data, repo)
    assert_equal Customer, c.class
  end

  def test_it_has_an_id
    skip
    c = Customer.new(data, repo)
    assert_equal 6, c.id
  end

  def test_it_has_a_first_name
    skip
    c = Customer.new(data, repo)
    assert_equal "Joan", c.first_name
  end

  def test_it_has_a_last_name
    skip
    c = Customer.new(data, repo)
    assert_equal "Clarke", c.last_name
  end

  def test_it_displays_when_it_was_created
    skip
    c = Customer.new(data, repo)
    assert_equal "2016-01-11 20:59:20 UTC", c.created_at
  end
  
  def test_it_displays_when_it_was_updated
    skip
    tc = Customer.new(data, repo)
    assert_equal "2009-12-09 12:08:04 UTC", c.updated_at
  end
end
