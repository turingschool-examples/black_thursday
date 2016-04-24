require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < MiniTest::Test

  attr_reader :cr

  def setup
    test_helper = TestHelper.new
    @cr = CustomerRepository.new(test_helper.customers)
  end

  def test_it_can_return_an_array_of_all_customers
    assert_equal [], cr.all
  end

end
