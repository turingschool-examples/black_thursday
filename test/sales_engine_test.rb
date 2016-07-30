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

  def test_it_returns_a_merchant_based_on_item_id
    se = SalesEngine.from_csv({ :items     => "./data/items.csv",
                                :merchants => "./data/merchants.csv" })

    item = se.items.find_by_id(263397059)
    assert_instance_of Merchant, item.merchant
    assert_equal "FlavienCouche", item.merchant.name

    item = se.items.find_by_id(263396279)
    assert_instance_of Merchant, item.merchant
    assert_equal "MuttisStrickwaren", item.merchant.name

    item = se.items.find_by_id(263395617)
    assert_instance_of Merchant, item.merchant
    assert_equal "Madewithgitterxx", item.merchant.name
  end

  def test_it_returns_single_item_based_on_merchant_id
    se = SalesEngine.from_csv({ :items     => "./data/items.csv",
                                :merchants => "./data/merchants.csv" })

    merchant = se.merchants.find_by_id(12334115)
    list_of_items = merchant.items
    names_of_items = list_of_items.map do |item|
      item.name
    end
    names = ["French bulldog cushion cover 45x45cm *cover only, pad NOT included*"]
    assert_instance_of Item, list_of_items.first
    assert_equal names, names_of_items
  end

  def test_it_returns_multiple_items_based_on_another_merchant_id
    se = SalesEngine.from_csv({ :items     => "./data/items.csv",
                                :merchants => "./data/merchants.csv" })

    merchant = se.merchants.find_by_id(12334132)
    list_of_items = merchant.items
    names_of_items = list_of_items.map do |item|
      item.name
    end
    names = ["sautoir boheme chic perle de gemme  montee sur chainette argentée", "sautoir ethique couleur naturel printemps été", "sautoir boheme chic  en perle et pierre"]

    assert_instance_of Item, list_of_items.first
    assert_equal names, names_of_items
  end

#  For Invoice CONNECTION
#   se = SalesEngine.from_csv({
#   :items => "./data/items.csv",
#   :merchants => "./data/merchants.csv",
#   :invoices => "./data/invoices.csv"
# })
# merchant = se.merchants.find_by_id(10)
# merchant.invoices
# # => [<invoice>, <invoice>, <invoice>]
# invoice = se.invoices.find_by_id(20)
# invoice.merchant
# # => <merchant>
end
