require_relative 'test_helper'
require_relative '../lib/items_price_analyst'

class ItemsPriceAnalystTest < Minitest::Test

  attr_reader :engine, :analyst

  def setup 
    @engine = SalesEngine.from_csv({:items => './test/assets/test_items.csv', 
                                    :merchants => './test/assets/test_merchants.csv', 
                                    :invoices => "./test/assets/test_invoices.csv", 
                                    :invoice_items => "./test/assets/test_invoice_items.csv",
                                    :transactions => "./test/assets/test_transactions.csv",
                                    :customers => "./test/assets/test_customers.csv"})
    @analyst = ItemsPriceAnalyst.new(engine)
  end

  def test_it_finds_average_price_of_one_merchant_in_analyst_class
    assert_equal 115.66, analyst.average_item_price_for_merchant(55).to_f
  end

  def test_analyst_finds_average_average_price_per_merchant_in_analyst_class
    assert_equal 100.42, analyst.average_average_price_per_merchant.to_f
  end

  def test_it_finds_golden_items_of_all_items_in_analyst_class
    golden_array = ["Solid Cherry Trestle Table : 5500.0"]
    found_items = analyst.golden_items.map { |item| "#{item.name} : #{item.unit_price_as_dollars}"}
    assert_equal golden_array, found_items
  end

end