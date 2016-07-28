require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def test_it_has_a_csv_method
    assert_respond_to(SalesEngine, :from_csv)
  end

  def test_it_takes_in_sample_merchant_csv
    se = SalesEngine.from_csv({ :items     => "./data/items.csv",
                                :merchants => "./data/merchants.csv" })

    assert_instance_of MerchantRepository, se.merchants
  end

  def test_it_takes_in_sample_item_csv
    se = SalesEngine.from_csv({ :items     => "./data/items.csv",
                                :merchants => "./data/merchants.csv" })

    assert_instance_of ItemRepository, se.items
  end

  def test_it_returns_a_merchant
    se = SalesEngine.from_csv({ :items     => "./data/items.csv",
                                :merchants => "./data/merchants.csv" })
    mr = se.merchants
    merchant = mr.find_by_name("CJsDecor")

    assert_instance_of Merchant, merchant
    assert_equal "CJsDecor",     merchant.name
    assert_equal 12337411,     merchant.id
  end

  def test_it_returns_an_item
    se = SalesEngine.from_csv({ :items     => "./data/items.csv",
                                :merchants => "./data/merchants.csv" })
    ir   = se.items
    item = ir.find_by_name("Glitter scrabble frames")

    assert_instance_of Item,                item
    assert_equal "Glitter scrabble frames", item.name
    assert_equal 263395617,               item.id
  end
end
