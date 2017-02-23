require 'minitest/autorun'
require 'minitest/pride'
require 'simplecov'
require 'pry'
require './lib/merchant'
require './lib/merchant_repository'

class SalesEngineTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({:items     => "./data/items.csv",
                                :merchants => "./data/merchants.csv"})
  end

end
