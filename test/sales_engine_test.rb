require 'minitest/autorun'
require 'minitest/pride'
require 'csv'
require './lib/sales_engine'
require 'pry'

class SalesEngineTest < Minitest::Test

  def test_it_exists
    assert SalesEngine.new
  end

end
