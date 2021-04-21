require_relative '../test/test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'

class SalesEngineTest < Minitest::Test

  def test_it_exits
    se = SalesEngine.new
    assert_instance_of SalesEngine, se
  end

  def test_it_can_load_from_csv
    se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
    })
  assert_instance_of SalesEngine, se
  end

  def test_it_can_return_an_instance_of_item_repo
    se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
    })
    assert_instance_of ItemRepository, se.items
  end

  def test_it_can_return_an_instance_of_merchant_repo
    se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
    })
    assert_instance_of MerchantRepository, se.merchants
  end

  def test_it_can_return_an_instance_of_item_repo
    se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
  :invoices => "./data/invoices.csv"
    })
    assert_instance_of InvoiceRepository, se.invoices
  end

  def test_it_can_create_a_sales_analyst_instance
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
        })
    assert_instance_of SalesAnalyst, se.analyst
  end
end
