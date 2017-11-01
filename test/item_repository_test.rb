require_relative 'test_helper'
require './lib/sales_engine'
require './lib/item_repository'


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
  #
  # def test_find_by_id_nil_or_with_id_number
  #   @item_repository.create_item({:name => "sample 1", :unit_price => 5000})
  #
  #   assert_nil @item_repository.find_by_id(5)
  #
  #   @item_repository.create_item({:name => "sample 1", :id => 5, :unit_price => 5000})
  #   item2 = @item_repository.items[1]
  #
  #   assert_equal item2, @item_repository.find_by_id(5)
  # end
  #
  # def test_that_finds_by_name
  #   assert_nil @item_repository.find_by_name("Trampoline")
  #
  #   @item_repository.create_item({:name => "sample 2", :unit_price => 5000})
  #   item1 = @item_repository.items[0]
  #
  #   assert_equal item1, @item_repository.find_by_name("sample 2")
  #
  # end
  #
  # def test_that_it_matches_items_with_similar_description
  #   @item_repository.create_item({:name => "doggo", :description => "bark", :unit_price => 5000})
  #   @item_repository.create_item({:name => "doggette", :description => "barker", :unit_price => 5000})
  #
  #   assert_empty @item_repository.find_all_with_description("meow")
  #   assert_equal @item_repository.items, @item_repository.find_all_with_description("bark")
  # end
  #
  # def test_that_it_matches_items_with_similar_merch_id
  #   @item_repository.create_item({:name => "doggo", :merchant_id => 20, :unit_price => 5000})
  #   @item_repository.create_item({:name => "doggette", :merchant_id => 20, :unit_price => 5000})
  #
  #   assert_empty @item_repository.find_all_by_merchant_id(2)
  #   assert_equal @item_repository.items, @item_repository.find_all_by_merchant_id(20)
  # end
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
