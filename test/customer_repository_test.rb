require_relative 'test_helper'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test
  attr_reader :cr

  def setup
    @cr = CustomerRepository.new("./data/customers.csv", self)
  end

  def test_customer_repo_instantiates

  end
