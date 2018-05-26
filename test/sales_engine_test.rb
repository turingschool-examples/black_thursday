require_relative 'test_helper.rb'
require './lib/csv_parser'
require './lib/sales_engine'
require 'pry'

class SalesEngineTest < Minitest::Test
  def test_it_exists
    se = SalesEngine.new

  end

end
