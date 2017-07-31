require_relative 'test_helper'
require_relative '../lib/item'
require_relative '../lib/sales_engine'

class ItemTest < Minitest::Test

  def test_item_exists
    item = Item.new({:id => 263399187, :name => "Spalted Maple Heart Box",
      :description => "spalted maple wood USA, handmade", :unit_price => 4800,
      :merchant_id => 12334365, :created_at => "2016-01-11 11:59:38 UTC",
      :updated_at => "1988-01-23 17:26:28 UTC"}, self)

    assert_instance_of Item, item
  end

  def test_item_has_id
    item = Item.new({:id => 263399187, :name => "Spalted Maple Heart Box",
      :description => "spalted maple wood USA, handmade", :unit_price => 4800,
      :merchant_id => 12334365, :created_at => "2016-01-11 11:59:38 UTC",
      :updated_at => "1988-01-23 17:26:28 UTC"}, self)
    id = item.id

    assert_equal 263399187, id
  end

  def test_item_has_name
    item = Item.new({:id => 263399187, :name => "Spalted Maple Heart Box",
      :description => "spalted maple wood USA, handmade", :unit_price => 4800,
      :merchant_id => 12334365, :created_at => "2016-01-11 11:59:38 UTC",
      :updated_at => "1988-01-23 17:26:28 UTC"}, self)
    name = item.name

    assert_equal "Spalted Maple Heart Box", name
  end

  def test_item_has_description
    item = Item.new({:id => 263399187, :name => "Spalted Maple Heart Box",
      :description => "spalted maple wood USA, handmade", :unit_price => 4800,
      :merchant_id => 12334365, :created_at => "2016-01-11 11:59:38 UTC",
      :updated_at => "1988-01-23 17:26:28 UTC"}, self)
    descrip = item.description

    assert_equal "spalted maple wood USA, handmade", descrip
  end

  def test_item_has_unit_price
    item = Item.new({:id => 263399187, :name => "Spalted Maple Heart Box",
      :description => "spalted maple wood USA, handmade", :unit_price => 4800,
      :merchant_id => 12334365, :created_at => "2016-01-11 11:59:38 UTC",
      :updated_at => "1988-01-23 17:26:28 UTC"}, self)
    unit_price = item.unit_price

    assert_instance_of BigDecimal, unit_price
    assert_equal 48.0, unit_price.to_f
  end

  def test_item_has_merchant_id
    item = Item.new({:id => 263399187, :name => "Spalted Maple Heart Box",
      :description => "spalted maple wood USA, handmade", :unit_price => 4800,
      :merchant_id => 12334365, :created_at => "2016-01-11 11:59:38 UTC",
      :updated_at => "1988-01-23 17:26:28 UTC"}, self)
    merch_id = item.merchant_id

    assert_equal 12334365, merch_id
  end

  def test_item_has_created_at_date
    item = Item.new({:id => 263399187, :name => "Spalted Maple Heart Box",
      :description => "spalted maple wood USA, handmade", :unit_price => 4800,
      :merchant_id => 12334365, :created_at => "2016-01-11 11:59:38 UTC",
      :updated_at => "1988-01-23 17:26:28 UTC"}, self)
    create_date = item.created_at

    assert_instance_of Time, create_date
  end

  def test_item_has_updated_at_date
    item = Item.new({:id => 263399187, :name => "Spalted Maple Heart Box",
      :description => "spalted maple wood USA, handmade", :unit_price => 4800,
      :merchant_id => 12334365, :created_at => "2016-01-11 11:59:38 UTC",
      :updated_at => "1988-01-23 17:26:28 UTC"}, self)
    update_date = item.updated_at

    assert_instance_of Time, update_date
  end

  def test_unit_price_dollar_conversion
    item = Item.new({:id => 263399187, :name => "Spalted Maple Heart Box",
      :description => "spalted maple wood USA, handmade", :unit_price => 4800,
      :merchant_id => 12334365, :created_at => "2016-01-11 11:59:38 UTC",
      :updated_at => "1988-01-23 17:26:28 UTC"}, self)
    unit_price_in_cents = 1200
    unit_price = item.unit_price_in_dollars(unit_price_in_cents)

    assert_equal 12.00, unit_price
  end

  def test_item_can_get_merchant
    se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })
    items = se.items
    item = items.find_all_by_merchant_id(12335119)[0]
    merchant = item.merchant

    assert_instance_of Merchant, merchant
  end

end
