require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require 'pry'
require './lib/customer_repo'

class CustomerRepositoryTest < MiniTest::Test

  def setup
    @engine = "engine"
    @cr = CustomerRepository.new (@engine)
  end

  def test_it_exists_with_attributes
    assert_instance_of CustomerRepository, @cr
    assert_equal @engine, @cr.engine
  end

  def test_building_a_customer
    assert_equal 1, @cr.customers[1].id
    assert_equal "Lempi", @cr.customers[369].first_name
    refute_equal "Trevor", @cr.customers[2].last_name
  end

  def test_all
    assert_equal 1000, @cr.all.length
    assert_equal Customer, @cr.all.first.class
  end
end