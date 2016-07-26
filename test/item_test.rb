require './test/test_helper'
require './lib/sales_engine'

class ItemTest < Minitest::Test

  def test_that_it_has_an_id
    item = Item.new({ id: "123", name: "Bill", description: "Good at being Bill", unit_price: "1000", merchant_id: "456", created_at: "2016-07-26 02:23:16 UTC", updated_at: "1970-04-01 12:45:13 UTC"})

    assert_equal "123", item.id
  end

  def test_that_it_has_a_name
    item = Item.new({ id: "123", name: "Bill", description: "Good at being Bill", unit_price: "1000", merchant_id: "456", created_at: "2016-07-26 02:23:16 UTC", updated_at: "1970-04-01 12:45:13 UTC"})

    assert_equal "Bill", item.name
  end

  def test_that_it_has_a_description
    item = Item.new({ id: "123", name: "Bill", description: "Good at being Bill", unit_price: "1000", merchant_id: "456", created_at: "2016-07-26 02:23:16 UTC", updated_at: "1970-04-01 12:45:13 UTC"})

    assert_equal "Good at being Bill", item.description
  end

  def test_that_it_has_a_unit_price_given_a_big_decimal
    item = Item.new({ id: "123", name: "Bill", description: "Good at being Bill", unit_price: BigDecimal.new(10.00, 4), merchant_id: "456", created_at: "2016-07-26 02:23:16 UTC", updated_at: "1970-04-01 12:45:13 UTC"})

    assert_equal BigDecimal(10.00, 4), item.unit_price
  end

  def test_that_it_has_a_unit_price_given_a_string
    item = Item.new({ id: "123", name: "Bill", description: "Good at being Bill", unit_price: "1000", merchant_id: "456", created_at: "2016-07-26 02:23:16 UTC", updated_at: "1970-04-01 12:45:13 UTC"})

    assert_equal BigDecimal(10.00, 4), item.unit_price
  end

  def test_that_it_has_a_merchant_id
    item = Item.new({ id: "123", name: "Bill", description: "Good at being Bill", unit_price: "1000", merchant_id: "456", created_at: "2016-07-26 02:23:16 UTC", updated_at: "1970-04-01 12:45:13 UTC"})

    assert_equal "456", item.merchant_id
  end

  def test_that_it_finds_when_created
    item = Item.new({ id: "123", name: "Bill", description: "Good at being Bill", unit_price: "1000", merchant_id: "456", created_at: "2016-07-26 02:23:16 UTC", updated_at: "1970-04-01 12:45:13 UTC"})

    assert_equal "2016-07-26 02:23:16 UTC", item.created_at
  end

  def test_that_it_finds_when_updated
    item = Item.new({ id: "123", name: "Bill", description: "Good at being Bill", unit_price: "1000", merchant_id: "456", created_at: "2016-07-26 02:23:16 UTC", updated_at: "1970-04-01 12:45:13 UTC"})

    assert_equal "1970-04-01 12:45:13 UTC", item.updated_at
  end

  def test_it_can_convert_unit_price_to_dollars
    item = Item.new({ id: "123", name: "Bill", description: "Good at being Bill", unit_price: "1000", merchant_id: "456", created_at: "2016-07-26 02:23:16 UTC", updated_at: "1970-04-01 12:45:13 UTC"})

    assert_equal 10.00, item.unit_price_to_dollars
  end







end
