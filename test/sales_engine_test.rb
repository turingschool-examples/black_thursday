require "./test/test_helper"
require "./lib/sales_engine"
require "./lib/item_repository"
require "./lib/merchant_repository"
require "./lib/merchant"
require "./lib/item"

class SalesEngineTest < Minitest::Test
  attr_reader :se

  # def setup
  #   csv_hash = {
  #     :items     => "./data/items.csv",
  #     :merchants => "./data/merchants.csv",
  #   }
  #   @se = SalesEngine.new(csv_hash)
  # end

  # def test_its_exists
  #   assert_instance_of SalesEngine, se
  # end

  def test_from_csv_creates_new_sales_engine
    csv_hash = {
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    }
    new_engine = SalesEngine.from_csv(csv_hash)

    assert_instance_of SalesEngine, new_engine

  end

  # def test_it_gets_a_csv
  # csv_hash = {
  #   :items     => "./data/items.csv",
  #   :merchants => "./data/merchants.csv",
  # }
  #   assert_equal "loaded", se.from_csv(csv_hash)
  # end
  #
  # def test_items
  #
  #   assert_instance_of ItemRepository, se.items
  # end
  #
  # def test_merchants
  #   assert_instance_of MerchantRepository, se.merchants
  # end

end
