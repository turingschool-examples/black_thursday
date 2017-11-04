require 'test_helper'
require 'csv'
require_relative './../lib/customer'
require_relative './../lib/customer_repository'

class CustomerTest < Minitest::Test
  attr_reader :repository

  def setup
    @repository = CustomerRepository.new("./test/fixtures/truncated_customers.csv")
  end
end