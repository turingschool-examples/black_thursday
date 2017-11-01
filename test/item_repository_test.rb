require_relative 'test_helper'
require './lib/sales_engine'
require './lib/item_repository'
require 'pry'

class ItemRepositoryTest < MiniTest::Test

  def setup
    @sales_engine = SalesEngine.from_csv({:items => './test/fixtures/items_fixture.csv', :merchants => './test/fixtures/merchants.csv'})
    @item_repository = @sales_engine.item_repository
  end

  def test_it_creates_items
    assert_equal 10, @item_repository.items.count
    assert_equal "Amy Winehouse drawing print", @item_repository.items[0].name
    assert_equal "Sex and the city drawing print", @item_repository.items[1].name
  end

  def test_that_it_finds_all
    assert_equal @item_repository.items, @item_repository.all
    assert_equal 10, @item_repository.items.count
  end

  def test_find_by_id_nil_or_with_id_number
    assert_nil @item_repository.find_by_id("263401670")
    assert_equal @item_repository.items[0], @item_repository.find_by_id("263401607")
  end

  def test_that_finds_by_name
    assert_nil @item_repository.find_by_name("Trampoline")
    assert_equal @item_repository.items[4], @item_repository.find_by_name("Black Jorts")
  end

  def test_that_it_matches_items_with_similar_description
    assert_equal ([]), @item_repository.find_all_with_description("meow")

    item1 = @item_repository.items[2]
    item2 = @item_repository.items[9]

    assert_equal [item1, item2], @item_repository.find_all_with_description("unbelievably")
    assert_equal [item1, item2], @item_repository.find_all_with_description("nbElIeVaBly")
  end

  def test_that_it_matches_items_with_similar_merch_id
    assert_equal ([]), @item_repository.find_all_by_merchant_id("263401607")

    item1 = @item_repository.items[0]
    item2 = @item_repository.items[1]

    assert_equal [item1, item2], @item_repository.find_all_by_merchant_id("12334112")
  end
  #
  # def test_that_it_finds_all_items_by_price
  #   @item_repository.create_item({:name => "doggo", :merchant_id => 20, :unit_price => 5000})
  #   @item_repository.create_item({:name => "doggette", :merchant_id => 20, :unit_price => 2000})
  #   @item_repository.create_item({:name => "doge", :merchant_id => 20, :unit_price => 2000})
  #   item1 = @item_repository.items[0]
  #   item2 = @item_repository.items[1]
  #   item3 = @item_repository.items[2]
  #
  #   assert_empty @item_repository.find_all_by_price(70)
  #   assert_equal [item1], @item_repository.find_all_by_price(50)
  #   assert_equal [item2, item3], @item_repository.find_all_by_price(20)
  # end
  #
  # def test_that_it_finds_all_items_by_price_in_range
  #   @item_repository.create_item({:name => "doggo", :merchant_id => 20, :unit_price => 5000})
  #   @item_repository.create_item({:name => "doggette", :merchant_id => 20, :unit_price => 2000})
  #   @item_repository.create_item({:name => "doge", :merchant_id => 20, :unit_price => 4000})
  #   item1 = @item_repository.items[0]
  #   item2 = @item_repository.items[1]
  #   item3 = @item_repository.items[2]
  #
  #   assert_empty @item_repository.find_all_by_price_in_range(70,90)
  #   assert_equal [item1], @item_repository.find_all_by_price_in_range(45,70)
  #   assert_equal [item2, item3], @item_repository.find_all_by_price_in_range(20,40)
  # end
  #
  #
end
