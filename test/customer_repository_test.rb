require_relative 'test_helper'
require_relative '../lib/customer_repository'
require_relative '../lib/customer'
require_relative '../lib/sales_engine'




class CustomerRepositoryTest < Minitest::Test

  def test_setup
    assert CustomerRepository.new.class
  end
end
