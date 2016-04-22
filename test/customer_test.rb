require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/customer'

class CustomerTest < Minitest::Test

  def test_setup
    assert Customer.new.class
  end
end
