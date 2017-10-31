require_relative 'test_helper'
# require 'minitest/autorun'
# require 'minitest/pride'
# require 'pry'
require './lib/item_repository'


class ItemRepositoryTest < MiniTest::Test

  def setup
    @item_repository = ItemRepository.new(nil)
  end


  def test_it_creates_items
    assert_equal 0, @item_repository.count
    @item_repository.create_item(:name => "sample 1")
    @item_repository.create_item(:name => "sample 2")

    assert_equal 2, @item_repository.count
    assert_equal "sample 1", @item_repository.items[0].name
    assert_equal "sample 2", @item_repository.items[1].name
  end

  def test_that_it_finds_all
    @item_repository.create_item(:name => "sample 1")
    @item_repository.create_item(:name => "sample 2")
    item1 = @item_repository.items[0]
    item2 = @item_repository.items[1]

    assert_equal [item1, item2], @item_repository.all
    assert_equal 2, @item_repository.items.count
  end

  def test_find_by_id_nil_or_with_id_number
    @item_repository.create_item(:name => "sample 1")

    assert_nil @item_repository.find_by_id(5)

    @item_repository.create_item(:name => "sample 1", :id => 5)
    item2 = @item_repository.items[1]

    assert_equal item2, @item_repository.find_by_id(5)
  end

  def test_that_finds_by_name
    assert_nil @item_repository.find_by_name("Trampoline")

    @item_repository.create_item(:name => "sample 2")
    item1 = @item_repository.items[0]

    assert_equal item1, @item_repository.find_by_name("sample 2")

  end

  def test_that_it_matches_items_with_similar_description
    @item_repository.create_item({:name => "doggo", :description => "bark"})
    @item_repository.create_item({:name => "doggette", :description => "barker"})
    item1 = @item_repository.items[0]
    item2 = @item_repository.items[1]

    assert_empty @item_repository.find_all_with_description("meow")
    assert_equal @item_repository.items, @item_repository.find_all_with_description("bark")
  end

  def test_that_it_matches_items_with_similar_merch_id
    @item_repository.create_item({:name => "doggo", :merchant_id => 20})
    @item_repository.create_item({:name => "doggette", :merchant_id => 20})
    item1 = @item_repository.items[0]
    item2 = @item_repository.items[1]

    assert_empty @item_repository.find_all_by_merchant_id(2)
    assert_equal @item_repository.items, @item_repository.find_all_by_merchant_id(20)
  end

end
