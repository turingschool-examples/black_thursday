require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'
require './lib/merchant_repo'
require 'pry'

class SalesEngineTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv(
                               {:items => "./test/fixtures/items.csv",
                                :merchants => "wherevermerchantslives"}
                            )
  end

  def test_it_exists
    assert_instance_of SalesEngine, @se
  end

  def test_it_can_populate_repos
    refute_empty @se.merchants.all
  end

end
