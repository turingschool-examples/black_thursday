require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer'
require_relative '../lib/customer_repo'
require_relative "../test/test_helper"


class CustomerTest < Minitest::Test
  attr_reader :data,
              :repo

  def setup
    @data = {:id => 6,
            :first_name => "Joan",
            :last_name => "Clarke",
            :created_at => "2009-12-09 12:08:04 UTC",
            :updated_at => "2436-08-27 22:19:07 UTC"}
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
    c = Customer.new(data, repo)
    assert_equal 6, c.id
  end

  def test_it_has_a_first_name
    c = Customer.new(data, repo)
    assert_equal "Joan", c.first_name
  end

  def test_it_has_a_last_name
    c = Customer.new(data, repo)
    assert_equal "Clarke", c.last_name
  end

  def test_it_displays_when_it_was_created
    c = Customer.new(data, repo)
    assert_equal "2009-12-09 12:08:04 UTC", c.created_at.to_s
  end
  
  def test_it_displays_when_it_was_updated
    c = Customer.new(data, repo)
    assert_equal "2436-08-27 22:19:07 UTC", c.updated_at.to_s
  end
end
