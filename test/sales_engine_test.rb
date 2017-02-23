require_relative 'test_helper.rb'
require_relative '../lib/sales_engine'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require 'pry'

class SalesEngineTest < Minitest::Test
  # def test_it_exists
  #   se = SalesEngine.new
  #
  #   assert_instance_of SalesEngine, se
  # end

  def test_item_instance_created
    se = SalesEngine.from_csv({
        :merchants     => "./test/fixtures/temp_merchants.csv",
        :items     => "./test/fixtures/temp_items.csv"
        })

    assert_instance_of ItemRepository, se.items
  end

  def test_merchant_instance_created
    se = SalesEngine.from_csv({
      :merchants     => "./test/fixtures/temp_merchants.csv",
      :items     => "./test/fixtures/temp_items.csv"
      })

      assert_instance_of MerchantRepository, se.merchants
  end

end
