require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require 'CSV'
require 'time'
require_relative '../lib/sales_engine'
require_relative '../lib/merchant_repo'

class SalesEngineTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv(
                               {:items => "./test/fixtures/items.csv",
                                :merchants => "./test/fixtures/merchants.csv"}
                            )
  end

  def test_it_exists
    assert_instance_of SalesEngine, @se
  end

  def test_it_can_populate_repos
    refute_empty @se.merchants.all
    refute_empty @se.items.all
  end
end
