require_relative './../lib/sales_engine'
require_relative 'spec_helper'
require          'pry'
require          'minitest/autorun'
require          'minitest/pride'


class SalesEngineTest < Minitest::Test

  def test_that_class_exist
    assert SalesEngine
  end

  def test_that_class_has_an_item_repository_instance
    se = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv"
                              })
    assert_equal ItemRepository, se.items.class
  end

  def test_that_class_has_a_merchant_repository_instance
    se = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv"
                              })

    assert_equal MerchantRepository, se.merchants.class
  end

  def test_that_object_created_on_self_is_a_kind_of_itself
    se = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv"
                              })

    assert_kind_of SalesEngine, se
  end

  def test_that_will_merchant_and_items_relationship_works
    se = SalesEngine.new(
    {
      items:     [ {id: 1, merchant_id: 1, name: "Vogue Paris 2307", unit_price: "2999",  :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"},
                   {id: 2, merchant_id: 1, name: "Givenchy 2307", unit_price: "2999",  :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"},
                   {id: 3, merchant_id: 2, name: "Givenchy 2307", unit_price: "2999",  :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"}],

      merchants: [{:id=>"1", :name=>"Shopin1901", :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"}]
      })

    merchant = se.merchants.find_by_id("1")
    assert_equal ["Vogue Paris 2307", "Givenchy 2307"], merchant.items.map(&:name)

    item = se.items.find_by_id(1)
    assert_equal "Shopin1901", item.merchant.name
  end

  def test_that_will_merchant_and_items_relationship_works_on_getting_the_unit_prices
    se = SalesEngine.new (
     {  items:    [{id: 1, merchant_id: 1, name: "Louis Wallet", unit_price: "2999",  :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"},
                    {id: 2, merchant_id: 2, name: "Yeezys", unit_price: "1000",  :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"},
                    {id: 3, merchant_id: 3, name: "Los Angeles Cap", unit_price: "40",  :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"}],

      merchants: [{:id=>"1", :name=>"Louis Vuitton", :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"},
                  {:id=>"2", :name=>"Nike", :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"},
                  {:id=>"2", :name=>"New Era", :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"}]})

    merchant = se.merchants.find_by_id(1)

    assert_equal ["Louis Wallet"], merchant.items.map(&:name)
    assert_equal         [2999.0], merchant.items.map(&:unit_price).map{ |x| x.to_f }
  end
end
