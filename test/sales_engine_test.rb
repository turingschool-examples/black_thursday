require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def test_it_exists
    sales_engine = SalesEngine.new

    assert_instance_of SalesEngine, sales_engine
  end

  def test_for_from_csv_method
    sales_engine = SalesEngine.new
    information = {:items => './data/items.csv',
                   :merchants => './data/merchants.csv'}
    sales_engine.from_csv(information)

    assert_equal information[:items], sales_engine.item_csv_path
    assert_equal information[:merchants], sales_engine.merchant_csv_path
  end

  def test_for_items_method
    sales_engine = SalesEngine.new
    information = {:items => './data/items.csv',
                   :merchants => './data/merchants.csv'}
    sales_engine.from_csv(information)
    ir = sales_engine.items

    assert ir.is_a?(ItemRepository)
  end

  # def test_for_merchants_method
  #   sales_engine = SalesEngine.new
  #   information = {:items => './data/items.csv',
  #                  :merchants => './data/merchants.csv'}
  #   sales_engine.from_csv(information)
  #   mr = sales_engine.merchants
  #
  #   assert ir.is_a?(MerchantRepository)
  # end
end
