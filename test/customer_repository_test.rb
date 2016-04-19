require './test/test_helper'
require './lib/customer_repository'
require './lib/customer'
require './lib/sales_engine'




class CustomerRepositoryTest < Minitest::Test

  def test_setup
    assert CustomerRepository.new.class
  end
end
