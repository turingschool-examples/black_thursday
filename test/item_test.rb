require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require 'bigdecimal'
require 'time'
require './lib/item_repository'
class ItemTest < Minitest::Test
  def setup
    merchant_path = './data/merchants.csv'
    item_path = './data/items.csv'
    locations = { items: item_path,
                  merchants: merchant_path }
    @engine = SalesEngine.new(locations)
    @ir = ItemRepository.new('./data/items.csv', @engine)
  end
  def test_it_exists_and_has_attributes
    i = Item.new({
  :id          => 1,
  :name        => "Pencil",
  :description => "You can use it to write things",
  :unit_price  => BigDecimal(10.99,4),
  :created_at  => "#{Time.now}",
  :updated_at  => "#{Time.now}",
  :merchant_id => 2
  }, @ir)
  assert_instance_of Item, i
  assert_equal 1, i.id
  assert_equal "Pencil", i.name
  assert_equal "You can use it to write things", i.description
  assert_equal BigDecimal(10.99,4) / 100, i.unit_price
  assert_instance_of Time, i.created_at
  assert_instance_of Time, i.updated_at
  assert_equal 2, i.merchant_id
  end
  def test_unit_price_converts_to_dollars
    i = Item.new({
  :id          => 1,
  :name        => "Pencil",
  :description => "You can use it to write things",
  :unit_price  => BigDecimal(10.99,4) * 100,
  :created_at  => "#{Time.now}",
  :updated_at  => "#{Time.now}",
  :merchant_id => 2
  },@ir)
  assert_equal 10.99, i.unit_price_to_dollars
  end
end
