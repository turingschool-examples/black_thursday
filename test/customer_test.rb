require './test/test_helper'
require './lib/sales_engine'
require './lib/customer'

class CustomerTest < Minitest::Test

  def test_setup
    assert Customer.new.class
  end
end
