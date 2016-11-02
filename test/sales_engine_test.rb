require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def test_sales_engine_class_exists
    assert_instance_of SalesEngine, SalesEngine.new
  end

  def test_sales_engine_knows_about_merchant_repo
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
      assert_instance_of MerchantRepo, se.merchants
    end

    def test_sales_engine_knows_about_item_repo
      se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
        })
        assert_instance_of ItemRepo, se.items
      end

      def test_sales_engine_knows_about_find_by_name_in_merchant_repo
        se = SalesEngine.from_csv({
          :items     => "./data/items.csv",
          :merchants => "./data/merchants.csv",
          })
          assert se.merchants.find_by_name("Shopin1901").include?("12334105")
      end
      #
      # def test_sales_engine_knows_about_find_by_name_in_merchant_repo
      #
      # end
    end
