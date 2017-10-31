require_relative './test_helper'

class TestSalesEngine < Minitest::Test
    def test_it_exists
      se = SalesEngine.new()

      assert_instance_of SalesEngine, se
      assert_nil se.item_repository
      assert_nil se.merchant_repository
    end

    def test_item_repository_populated_after_load
      se = SalesEngine.new()
      se.from_csv({
        :items => "./test/item_fixture.csv",
        :merchants => './test/merchants_fixture.csv'
        })

      assert_instance_of ItemRepository, se.item_repository
      assert_equal 4, se.item_repository.items.count
      assert_instance_of MerchantRepository, se.merchant_repository
      assert_equal 5, se.merchant_repository.merchants.count
    end

end
