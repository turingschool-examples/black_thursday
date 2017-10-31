require_relative './test_helper'

class TestSalesEngine < Minitest::Test
    def test_it_exists
      se = SalesEngine.new(
        'item_repository',
        'merchant_repository',
        'invoice_repository'
      )

      assert_instance_of SalesEngine, se
      assert_equal 'item_repository', se.item_repository
      assert_equal 'merchant_repository', se.merchant_repository
      assert_equal 'invoice_repository', se.invoice_repository
    end

    def test_item_repository_populated_after_load
      se = SalesEngine.from_csv({
        :items => "./test/item_fixture.csv",
        :merchants => './test/merchants_fixture.csv',
        :invoices => './test/invoice_fixture.csv'
        })

      assert_instance_of ItemRepository, se.item_repository
      assert_equal 4, se.item_repository.items.count
      assert_instance_of MerchantRepository, se.merchant_repository
      assert_equal 5, se.merchant_repository.merchants.count
      assert_instance_of InvoiceRepository, se.invoice_repository
      assert_equal 5, se.invoice_repository.invoices.count
    end
end
