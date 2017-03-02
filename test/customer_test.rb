require 'minitest/autorun'
require 'time'
require 'minitest/pride'
require_relative '../lib/sales_engine'
require_relative '../lib/repository'
require_relative '../lib/customer'

class CustomerTest < Minitest::Test

  attr_reader :repo, :customer

  def setup
    @customer = Customer.new( {
    :id => 1,
    :first_name => "Joey",
    :last_name => "Ondricka",
    :created_at => "2012-03-27 14:54:10 UTC",
    :updated_at => "2012-03-27 14:54:10 UTC",
    }, repo)
  end

  def test_it_finds_an_id
    assert_equal 1, customer.id
  end

  def test_it_finds_a_first_name
    assert_equal "Joey", customer.first_name
  end

  def test_it_finds_a_last_name
    assert_equal "Ondricka", customer.last_name
  end

  def test_it_finds_a_created_at_date
    assert_equal Time, customer.created_at.class
  end

  def test_it_finds_an_updated_at_date
    assert_equal Time, customer.updated_at.class
  end

end
