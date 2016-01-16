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
    item = se.items.find_by_id(3)

    assert_equal Merchant, item.merchant.class
  end

  def test_that_will_start_the_function
    #these tests only use the .new since they are already converted into a hash
    #we only want to use the .from_csv when we are actually loading the data
    se = SalesEngine.new(
    {
      items:     [ {id: "1", merchant_id:  "1", name: "Vogue Paris 2307", unit_price: "2999",  :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"},
                   {id: "2", merchant_id: "1", name: "Givenchy 2307", unit_price: "2999",  :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"},
                   {id: "3", merchant_id: "2", name: "Givenchy 2307", unit_price: "2999",  :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"}],

      merchants: [{:id=>"1", :name=>"Shopin1901", :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"}]
      })


    merchant = se.merchants.find_by_id("1")

    item = se.items.find_by_id("1")
      #BY ITEM ID COMPARED TO MERCHANT ID
    assert_equal 1, item.merchant
      # => <merchant>
  end
end
