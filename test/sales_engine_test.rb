require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'
require './lib/merchant_repo'
require './lib/data_parser'
class SalesEngineTest < Minitest::Test
  include DataParser

  def test_sales_engine_knows_about_merchant_repo
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
      assert_instance_of Merchant, se.merchants.all.first
      assert_instance_of Merchant, se.merchants.all.last
    end

    def test_sales_engine_knows_about_item_repo
      se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
        })
        assert_instance_of Item, se.items.all.first
      end

      def test_sales_engine_knows_about_find_by_name_in_merchant_repo
        se = SalesEngine.from_csv({
          :items     => "./data/items.csv",
          :merchants => "./data/merchants.csv",
          })
          merchant = se.merchants.find_by_name("Shopin1901")
          assert_equal "Shopin1901", merchant.name
      end

      # def test_sales_engine_knows_about_find_by_name_in_merchant_repo
      #
      # end
    end
