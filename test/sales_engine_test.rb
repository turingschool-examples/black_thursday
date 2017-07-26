require 'bigdecimal'
require './lib/sales_engine'
require 'csv'
require 'minitest/autorun'
require 'minitest/emoji'

class SalesEngineTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
              :items => "./test/data/items_fixture.csv",
              :merchants => "./test/data/merchants_fixture.csv",
              :invoice_items => "./test/data/invoice_items_fixture.csv",
              :invoices => "./test/data/invoices_fixture.csv",
              :transactions => "./test/data/transactions_fixture.csv",
              :customers => "./test/data/customers_fixture.csv"
            })
  end

  def test_it_exists
    assert_instance_of SalesEngine, @se
  end

  def test_it_has_an_item_repository
    assert_instance_of ItemRepository, @se.item
  end

  def test_it_has_a_merchant_repository
    assert_instance_of MerchantRepository, @se.merchant
  end

end
