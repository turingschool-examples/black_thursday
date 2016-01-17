require_relative './../lib/sales_engine'
require_relative 'spec_helper'
require          'pry'
require          'minitest/autorun'
require          'minitest/pride'


class SalesEngineTest < Minitest::Test
  attr_reader :se

  def test_that_class_exist
    assert SalesEngine
  end

  def setup
    @se = SalesEngine.from_csv({
                              :items     => "./data/sample/items_sample.csv",
                              :merchants => "./data/sample/merchants_sample.csv",
                              :invoices  => "./data/sample/invoice_sample.csv"
                              })
  end

  def test_that_class_has_an_item_repository_instance
    assert_equal ItemRepository, se.items.class
  end

  def test_that_class_has_a_merchant_repository_instance
    assert_equal MerchantRepository, se.merchants.class
  end

  def test_that_will_merchant_and_items_relationship_works
    merchant = se.merchants.find_by_id("11")
    assert_equal ["First Item Name"], merchant.items.map(&:name)

    item = se.items.find_by_id("1111")
    assert_equal "Store One", item.merchant.name
  end

  def test_that_will_merchant_and_items_relationship_works_on_getting_the_unit_prices
    merchant = se.merchants.find_by_id(22)
    assert_equal ["Second Item Name", "Third Item Name", "Fourth Item Name"], merchant.items.map(&:name)
    assert_equal [222.0, 33.0, 444.0], merchant.items.map(&:unit_price).map{ |x| x.to_f }
  end

  def test_that_the_relationship_between_the_invoices_and_merchants_exist
    # binding.pry
    merchant = se.merchants.find_by_id(22)
    merchant.invoices
    # => [<invoice>, <invoice>, <invoice>]
    # binding.pry
    invoice = se.invoices.find_by_id(1)
    invoice.merchant
  end
end
