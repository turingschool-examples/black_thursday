require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item_repository.rb'
require_relative '../lib/item.rb'
require_relative '../lib/sales_engine.rb'
require_relative '../lib/merchant.rb'
require_relative '../lib/merchant_repository.rb'
require 'pry'

class ItemRepositoryTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/dummy_items.csv",
      :merchants => "./data/dummy_merchants.csv"
      })


  end

  def test_it_exists
    se = SalesEngine.from_csv({
      :items     => "./data/dummy_items.csv",
      :merchants => "./data/dummy_merchants.csv"
      })
    ir = ItemRepository.new(se.csv_hash[:items])
    assert_instance_of ItemRepository, ir
  end

  def test_it_creates_items
    se = SalesEngine.from_csv({
      :items     => "./data/dummy_items.csv",
      :merchants => "./data/dummy_merchants.csv"
      })
    ir = ItemRepository.new(se.csv_hash[:items])
    assert_equal [ ] , ir.items
  end

  def test_all_array
    se = SalesEngine.from_csv({
      :items     => "./data/dummy_items.csv",
      :merchants => "./data/dummy_merchants.csv"
      })
    ir = ItemRepository.new(se.csv_hash[:items])
    assert_equal [ ], ir.all
  end

  def test_can_find_by_id
    se = SalesEngine.from_csv({
      :items     => "./data/dummy_items.csv",
      :merchants => "./data/dummy_merchants.csv"
      })
    ir = ItemRepository.new(se.csv_hash[:items])
    ir.create_items
    assert_equal Item, ir.find_by_id("263395237").class
  end

  def test_find_all_by_price
    skip
    se = SalesEngine.from_csv({
      :items     => "./data/dummy_items.csv",
      :merchants => "./data/dummy_merchants.csv"
      })
    ir = ItemRepository.new(se.csv_hash[:items])
    ir.find_all_by_price(700)
    assert_equal 700 , ir.find_all_by_price(700)
  end

  def test_find_all_with_description
    se = SalesEngine.from_csv({
      :items     => "./data/dummy_items.csv",
      :merchants => "./data/dummy_merchants.csv"
      })
    ir = ItemRepository.new(se.csv_hash[:items])
    ir.create_items
    ir.find_all_with_description("Disney glitter frames")
    #binding.pry
    assert_equal ir.find_all_with_description("Disney glitter frames").class
  end

end
