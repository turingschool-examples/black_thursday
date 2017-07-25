require 'simplecov'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/customer_repo'

class CustomerRepositoryTest < Minitest::Test

  def test_it_exist
    customer_repo = CustomerRepository.new

    assert_instance_of CustomerRepository, customer_repo
  end

end
