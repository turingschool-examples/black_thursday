require './test/test_helper'
require './lib/salesengine'

class SalesEngineTest < Minitest::Test
  def test_it_exists
    assert SalesEngine.new({  :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv", })
  end

  def test_it_has_a_csv_method
    assert_respond_to(SalesEngine, :from_csv)
  end

  def test_it_takes_in_sample_merchant_csv
    se = SalesEngine.from_csv({:merchants => "./data/merchants_sample.csv"})
    assert_instance_of MerchantRepository, se.merchants
  end

  def test_it_returns_a_merchant
    se = SalesEngine.new({  :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv", })

    # se = SalesEngine.from_csv({
    #   :items     => "./data/items.csv",
    #   :merchants => "./data/merchants.csv",
    # })
    mr = se.merchants
    merchant = mr.find_by_name("CJsDecor")

    assert_instance_of Merchant, merchant
    assert_equal "CJsDecor",     merchant.name
    assert_equal "12337411",     merchant.id
  end

  def test_it_returns_an_item
    se = SalesEngine.from_csv({ :items     => "./data/items.csv",
                                :merchants => "./data/merchants.csv" })
    ir   = se.items
    item = ir.find_by_name("Item Repellat Dolorum")

    assert_instance_of Item, item
    assert_equal "place_holder", item.name
    assert_equal "place_holder", item.id
  end
end




#return value
#method to parse csv (file name = hash: key, merchants)
#as you iterate through, a new merchant can be created on every row, and be
#stored in a merchant repository array
#merchants and repo are created, then
