require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_it_exists
    sales = SalesEngine.new

    assert_instance_of SalesEngine, sales    

  end


end
