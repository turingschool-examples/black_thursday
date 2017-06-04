require 'csv'
require_relative 'test_helper'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < MiniTest::Test

  def test_if_class_creates
    cr = CustomerRepository.new

    assert_instance_of CustomerRepository, cr    
  end


end
