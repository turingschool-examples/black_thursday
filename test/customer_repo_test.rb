require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require 'pry'
require './lib/customer_repo'

class CustomerRepositoryTest < MiniTest::Test

  def setup
    @cr = CustomerRepository.new
  end

  def test_it_exists
    assert_instance_of CustomerRepository, @cr
  end
end