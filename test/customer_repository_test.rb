require './test/test_helper'
require './lib/sales_engine'
require './lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test

  def test_setup
    assert CustomerRepository.new.class
  end
end
