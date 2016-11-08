require_relative 'test_helper'
require_relative '../lib/items_count_analyst'

class ItemsCountAnalystTest < Minitest::Test

  attr_reader :engine, :analyst

  def setup 
    @engine = SalesEngine.from_csv({:items => './test/assets/test_items.csv', 
                                    :merchants => './test/assets/test_merchants.csv', 
                                    :invoices => "./test/assets/test_invoices.csv", 
                                    :invoice_items => "./test/assets/test_invoice_items.csv",
                                    :transactions => "./test/assets/test_transactions.csv",
                                    :customers => "./test/assets/test_customers.csv"})
    @analyst = ItemsCountAnalyst.new(engine)
  end


  def test_analyst_returns_average_items_per_merchant_in_analyst_class
    assert_equal 2.13, analyst.average_items_per_merchant.round(2)
  end

  def test_analyst_returns_average_items_per_merchant_standard_deviation_in_analyst_class
    assert_equal 1.86, analyst.average_items_per_merchant_standard_deviation.round(2)
  end

  def test_it_returns_high_item_count_in_analyst_class
    expected_array = ["Shopin1901 : 6", "Candisart : 4", "MiniatureBikez : 4", "LolaMarleys : 5", "perlesemoi : 5", "Urcase17 : 5", "BowlsByChris : 4", "NicSueDesigns : 4"]
    found_merchants = analyst.merchants_with_high_item_count.map { |merchant| "#{merchant.name} : #{merchant.items.count}"}
    assert_equal expected_array, found_merchants
  end

  def test_it_returns_merchants_with_one_item_in_analyst_class
    assert_equal 3, analyst.merchants_with_only_one_item.count
  end

end