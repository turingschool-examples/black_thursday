require './test/test_helper'
require './lib/sales_engine'

class MerchantTest < Minitest::Test

  def test_that_it_has_an_id
    merchant = Merchant.new({ id: 123, name: "Bill"})

    assert_equal 123, merchant.id
  end

  def test_that_it_has_a_name
    merchant = Merchant.new({ id: 123, name: "Bill"})

    assert_equal "Bill", merchant.name
  end

  def test_that_an_merchant_points_to_its_items
    se = SalesEngine.from_csv({ items: "./test/samples/item_sample.csv", merchants: "./test/samples/merchants_sample.csv" })
    merchant = se.merchants.find_by_id(12334185)

    assert_instance_of Item, merchant.items.first
    assert_equal 7, merchant.items.count

    assert_equal "Glitter scrabble frames", merchant.items[0].name
  end

  def test_that_a_merchant_points_to_its_invoices
    se = SalesEngine.from_csv({ items: "./test/samples/item_sample.csv", merchants: "./test/samples/merchants_sample.csv", invoices: "./test/samples/invoices_sample.csv" })
    merchant = se.merchants.find_by_id(12334266)

    assert_equal 100, merchant.invoices[0].id
  end

end
