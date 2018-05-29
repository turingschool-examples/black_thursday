require './test_helper'
require './lib/item'
require './lib/item_repository'
require './lib/file_loader'
require './lib/sales_engine'
require 'bigdecimal'
require 'pry'

class ItemRepositoryTest < MiniTest::Test
  include FileLoader
  def test_it_exists
    se = SalesEngine.from_csv({
      :items => "./data/item_sample.csv",
      :merchants => "./data/merchant_sample.csv"
    })
    ir = se.items

    assert_instance_of ItemRepository, ir
  end

  def test_items_starts_as_an_empty_array
    se = SalesEngine.from_csv({
      :items => "./data/item_sample.csv",
      :merchants => "./data/merchant_sample.csv"
    })
    ir = se.items

    assert_instance_of Array, ir.all
  end

  def test_it_can_create_items
    se = SalesEngine.from_csv({
      :items => "./data/item_sample.csv",
      :merchants => "./data/merchant_sample.csv"
    })
    ir = se.items
    attributes = {
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now
    }
    ir.create(attributes)

    assert_equal 263395239, ir.all[-2].id
    assert_equal 263395240, ir.all[-1].id
    assert_equal 'Pencil', ir.all.last.name 
  end
  # def test_it_exists
  #   se = SalesEngine.from_csv({
  #     :items => "./data/item_sample.csv",
  #     :merchants => "./data/merchant_sample.csv"
  #   })
  #   ir = se.items
  #
  #   assert_instance_of ItemRepository, ir
  # end
  # def test_it_exists
  #   se = SalesEngine.from_csv({
  #     :items => "./data/item_sample.csv",
  #     :merchants => "./data/merchant_sample.csv"
  #   })
  #   ir = se.items
  #
  #   assert_instance_of ItemRepository, ir
  # end
  # def test_it_exists
  #   se = SalesEngine.from_csv({
  #     :items => "./data/item_sample.csv",
  #     :merchants => "./data/merchant_sample.csv"
  #   })
  #   ir = se.items
  #
  #   assert_instance_of ItemRepository, ir
  # end
  # def test_it_exists
  #   se = SalesEngine.from_csv({
  #     :items => "./data/item_sample.csv",
  #     :merchants => "./data/merchant_sample.csv"
  #   })
  #   ir = se.items
  #
  #   assert_instance_of ItemRepository, ir
  # end
  # def test_it_exists
  #   se = SalesEngine.from_csv({
  #     :items => "./data/item_sample.csv",
  #     :merchants => "./data/merchant_sample.csv"
  #   })
  #   ir = se.items
  #
  #   assert_instance_of ItemRepository, ir
  # end
  # def test_it_exists
  #   se = SalesEngine.from_csv({
  #     :items => "./data/item_sample.csv",
  #     :merchants => "./data/merchant_sample.csv"
  #   })
  #   ir = se.items
  #
  #   assert_instance_of ItemRepository, ir
  # end
  # def test_it_exists
  #   se = SalesEngine.from_csv({
  #     :items => "./data/item_sample.csv",
  #     :merchants => "./data/merchant_sample.csv"
  #   })
  #   ir = se.items
  #
  #   assert_instance_of ItemRepository, ir
  # end


end
