require 'minitest/autorun'
require 'minitest/pride'
require 'csv'
require 'time'
require 'bigdecimal'
require 'pry'
require_relative '../lib/item_repository'
require_relative '../sales_engine'

class ItemRepositoryTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({:items => './test/fixtures/items_fixture.csv'})
    @ir = se.items
    @items = ItemRepository.new
    @item_one = Item.new({
            :id => 2,
            :name => "Lighter",
            :description => "It comes in ten colors",
            :unit_price => 30
            :created_at => "2011-03-11 15:51:37 UTC"
            :updated_at => "1997-03-19 20:02:43 UTC"
            :merchant_id => "12334113"
            })
    @item_two = Item.new({
            :id => 4,
            :name => "Pencil",
            :description => "You can use it to write",
            :unit_price => 1200
            :created_at => "2016-01-11 11:51:37 UTC"
            :updated_at => "1995-03-19 10:02:43 UTC"
            :merchant_id => "12334105"
            })
    @item_three = Item.new({
            :id => 5,
            :name => "Dwarf",
            :description => "Decorate your front yard.",
            :unit_price => 750
            :created_at => "2002-01-20 09:51:37 UTC"
            :updated_at => "1999-03-19 15:02:43 UTC"
            :merchant_id => "12334112"
            })
  end

  def test_creates_array_of_items
    items = ItemRepository.new
    # item_one = Item.new({
    #         :id => 2,
    #         :name => "Lighter",
    #         :description => "It comes in ten colors",
    #         :unit_price => 30
    #         :created_at => "2011-03-11 15:51:37 UTC"
    #         :updated_at => "1997-03-19 20:02:43 UTC"
    #         :merchant_id => "12334113"
    #         })
    # item_two = Item.new({
    #         :id => 4,
    #         :name => "Pencil",
    #         :description => "You can use it to write",
    #         :unit_price => 1200
    #         :created_at => "2016-01-11 11:51:37 UTC"
    #         :updated_at => "1995-03-19 10:02:43 UTC"
    #         :merchant_id => "12334105"
    #         })
    # item_three = Item.new({
    #         :id => 5,
    #         :name => "Dwarf",
    #         :description => "Decorate your front yard.",
    #         :unit_price => 750
    #         :created_at => "2002-01-20 09:51:37 UTC"
    #         :updated_at => "1999-03-19 15:02:43 UTC"
    #         :merchant_id => "12334112"
    #         })
    expected = @items.make_items(@item_one, @item_two, @item_three)

    assert_equal [@item_one, @item_two, @item_three], expected
  end

  def test_it_returns_all_items
    items = ItemRepository.new
  end

  def test_it_finds_items_by_id

  end
end
