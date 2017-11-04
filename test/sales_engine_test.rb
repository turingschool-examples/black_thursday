require_relative './test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
    attr_reader :se

    def setup
      @se = SalesEngine.from_csv({
        :items => "./test/fixture/item_truncated.csv",
        :merchants => './test/fixture/merchants_truncated.csv',
        :invoices => './test/fixture/invoice_truncated.csv'}
      )
    end

    def test_repositories_populated_after_load
      assert_instance_of SalesEngine, se
      assert_instance_of ItemRepository, se.items
      assert_equal 8, se.items.items.count
      assert_instance_of MerchantRepository, se.merchants
      assert_equal 5, se.merchants.merchants.count
      assert_instance_of InvoiceRepository, se.invoices
      assert_equal 20, se.invoices.invoices.count
    end

    def test_find_items_for_merchant_by_merchant_id
      merchant = se.merchants.find_by_id('12334185')

      assert_equal 4, merchant.items.count
    end

    def test_find_merchant_for_item_by_merchant_id
      item = se.items.find_by_id('263395721')

      assert_equal 'Madewithgitterxx', item.merchant.name
    end

    def test_find_invoices_for_merchant
      merchant = se.merchants.find_by_id('12334185')

      assert_equal 10, merchant.invoices.count
    end
end
