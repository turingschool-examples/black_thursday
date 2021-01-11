require_relative './test_helper'
require 'mocha/minitest'
require 'csv'
require 'bigdecimal'
require './lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test
  def setup
    @engine = mock
    @repository = CustomerRepository.new("./data/customers.csv", @engine)
  end

  def test_it_exists
    assert_instance_of CustomerRepository, @repository
  end

  # def test_it_has_attributes
  #   assert_equal "filler", @repository.filler
  # end
  #
  # def test_it_can_have_different_attributes
  # end

end
