require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
attr_reader :se_hash

  def setup
    @se_hash = {:items => './data/test_items.csv',
            :merchants => './data/test_merchant.csv',
            :invoices => './data/test_invoices.csv'}
  end

  def test_an_instance_of_sales_engine_exists
    se = SalesEngine.new(se_hash)
    assert se.instance_of?(SalesEngine)
  end

  def test_items_instantiates_items_repo
    se = SalesEngine.from_csv(se_hash)
    item = se.items
    assert item.instance_of?(ItemRepository)
  end

  def test_items_instantiates_merchants_repo
    se = SalesEngine.from_csv(se_hash)
    merchants = se.merchants
    assert merchants.instance_of?(MerchantRepository)
  end

  def test_items_returns_item_repo_instance
    se = SalesEngine.from_csv(se_hash)
    item = se.items
    assert_equal 5, item.all.count
  end

  def test_merchants_returns_merchant_repo_instance
    se = SalesEngine.from_csv(se_hash)
    merchants = se.merchants
    assert_equal 5, merchants.all.count
  end

  def test_sales_engine_can_find_by_id
    se = SalesEngine.from_csv(se_hash)
    merchants = se.merchants
    found = merchants.find_by_id(1)
    assert_equal "Schroeder-Jerde", found.name
  end

end
