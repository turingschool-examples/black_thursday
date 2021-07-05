require_relative 'test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def setup
    @se = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
  end

  def test_it_exists

  assert_instance_of SalesEngine, @se
  end

  def test_it_can_create_new_instance_of_csv_file
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })

      assert_instance_of SalesEngine, se
  end

  def test_merchants_makes_repository_of
    assert_instance_of MerchantRepository, @se.merchants
  end
end
