require_relative 'test_helper.rb'
require './lib/csv_parser'
require './lib/sales_engine'
require 'pry'

class SalesEngineTest < Minitest::Test
  def test_it_exists
    se = SalesEngine.new
    assert_instance_of(SalesEngine, se)
  end

  def test_from_csv_creates_merchant_repository
    se = SalesEngine.new
    merchants_hash = {:merchants => "./data/merchants.csv"}
    se.from_csv(merchants_hash)
    assert_equal MerchantRepository, se.merchants.class
  end
end
