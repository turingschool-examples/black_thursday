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
    skip
    se = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv"
                              })

    assert_kind_of SalesEngine, se
  end


  def test_that_merchant_knows_its_items
    se = SalesEngine.new(
    {
      items:     [ {id: 1, merchant_id:  "1", name: "Vogue Paris 2307", unit_price: "2999",  :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"},
                   {id: 2, merchant_id: "1", name: "Givenchy 2307", unit_price: "2999",  :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"},
                   {id: 3, merchant_id: "2", name: "Givenchy 2307", unit_price: "2999",  :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"}],

      merchants: [{:id=>"1", :name=>"Shopin1901", :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"}]
      })

    merchant = se.merchants.find_by_id("1")
    assert_equal ["Vogue Paris 2307", "Givenchy 2307"], merchant.items.map(&:name)
    # item = se.items.find_by_id(3)

    # assert_equal Merchant, item.merchant.class
  end

  def test_that_will_start_the_function
    se = SalesEngine.new(
    {
      items:     [ {id: 1, merchant_id: 1, name: "Vogue Paris 2307", unit_price: "2999",  :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"},
                   {id: 2, merchant_id: 1, name: "Givenchy 2307", unit_price: "2999",  :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"},
                   {id: 3, merchant_id: 2, name: "Givenchy 2307", unit_price: "2999",  :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"}],

      merchants: [{:id=>"1", :name=>"Shopin1901", :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"}]
      })

    merchant = se.merchants.find_by_id("1")
    #merchant is asking for an input that will connect its "1" with the merchant id
    assert_equal ["Vogue Paris 2307", "Givenchy 2307"], merchant.items.map(&:name)
    #from here, all I'm getting is the merchant items that matched in line 69 to
    #the merchant's own ID
    item = se.items.find_by_id(1)
    #here I'm inputting the item's ID
    #item.merchant.name connects me to the merchant_id and gets me its name "Shopin1901"
    assert_equal "Shopin1901", item.merchant.name
  end
end
