require 'minitest/autorun'
require './lib/sales_engine'
require 'pry'
require 'csv'

class SalesEngineTest < Minitest:: Test
  def test_a_sales_engine_can_be_instantiated
    skip
    assert SalesEngine.new
  end
  def test_a_sales_engine_has_an_item_repository

    se = SalesEngine.new
    assert se.item_repository
  end
  def test_it_can_read_CSV
    se = SalesEngine.new
      se.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
      })
    assert_equal "263395237", se.items_store.first[:id]
  end
end

class ItemRepositoryTest < Minitest:: Test

  def test_it_creates_item
    skip
    ir = ItemRepository.new("")
    assert_equal 0, ir.count
    ir.create_item(:name=>"Sample 1")
    ir.create_item(:name=>"Sample 2")
    assert_equal "Sample 1", ir.items[0].name
    assert_equal "Sample 2", ir.items[1].name
  end
end

class ItemTest < Minitest:: Test
  def test_it_knows_it_came_from
    skip
    item_repo = ItemRepository.new("")
    item_repo.create_item(:name => "This Thing")
    item = item_repo.items.first

    assert_equal item_repo, item.repository
  end

  def test_it_can_find_the_associated_merchant
    skip

    se.merchant_repository.create_merchant({:name =>"the merch", :id => 24})
    merchant = se.merchant_repository.merchants.first
    se.item_repository.create_item({:name => "merchthang", :merchant_id => 24})
    item = se.item_repository.items.first

    assert_equal merchant,  item.merchant
  end
end
