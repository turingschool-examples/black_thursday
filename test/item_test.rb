require_relative 'test_helper'
require './lib/item'
require './lib/item_repository'
require './lib/sales_engine'
require './lib/merchant'


class ItemTest < MiniTest::Test

  def setup
    @sales_engine = SalesEngine.from_csv({:items => './test/fixtures/items_fixture.csv', :merchants => './test/fixtures/merchants.csv', :invoices => './test/fixtures/invoices.csv'})
    @items = @sales_engine.items.items
  end

  def test_it_knows_where_it_came_from
    @item_repository.create_item({:name => "The Thing", :unit_price => 5000})
    item = @items.first
    assert_equal @item_repository, item.parent
  end

  def test_it_can_find_the_merchant
    @sales_engine.merchant_repository.create_merchant({:name => "Mercher", :id => 24})
    merchant = @sales_engine.merchant_repository.merchants.first
    @sales_engine.item_repository.create_item({:name => "Thingy", :merchant_id => 24, :unit_price => 5000})
    item = @sales_engine.item_repository.items.first
    assert_equal merchant, item.merchant
  end

  def test_that_item_has_attributes
    @sales_engine.item_repository.create_item({:name => "A thing", :merchant_id => 6,
    :id => 5, :description => "does things", :unit_price => 5000})
    item = @sales_engine.item_repository.items.first

    assert_equal "A thing", item.name
    assert_equal "does things", item.description
    assert_equal 5, item.item_id
    assert_equal 6, item.merchant_id
    assert_equal 50, item.unit_price
  end

  def test_it_converts_price_to_dollars
    @sales_engine.item_repository.create_item({:name => "A thing", :merchant_id => 6,
    :id => 5, :description => "does things", :unit_price => 5000})
    item = @sales_engine.item_repository.items.first

    assert_equal 50.00, item.unit_price_to_dollars
  end

end
