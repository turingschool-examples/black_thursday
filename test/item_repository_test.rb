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

  def test_it_can_return_item_by_its_id
    se = SalesEngine.from_csv({
      :items => "./data/item_sample.csv",
      :merchants => "./data/merchant_sample.csv"
    })
    ir = se.items
    attributes_1 = {
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now
    }
    item_1 = ir.create(attributes_1)
    attributes_2 = {
      :name        => "Pen",
      :description => "You can use it to write other things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now
    }
    item_2 = ir.create(attributes_2)

    assert_equal item_1, ir.find_by_id(263395240)
    assert_equal item_2, ir.find_by_id(263395241)
  end

  def test_it_returns_nil_if_item_id_is_not_present
    se = SalesEngine.from_csv({
      :items => "./data/item_sample.csv",
      :merchants => "./data/merchant_sample.csv"
    })
    ir = se.items
    attributes_1 = {
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now
    }
    item_1 = ir.create(attributes_1)
    attributes_2 = {
      :name        => "Pen",
      :description => "You can use it to write other things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now
    }
    item_2 = ir.create(attributes_2)

    assert_nil ir.find_by_id(263395245)
  end

  def test_it_can_return_item_by_its_name
    se = SalesEngine.from_csv({
      :items => "./data/item_sample.csv",
      :merchants => "./data/merchant_sample.csv"
    })
    ir = se.items
    attributes_1 = {
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now
    }
    item_1 = ir.create(attributes_1)
    attributes_2 = {
      :name        => "Pen",
      :description => "You can use it to write other things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now
    }
    item_2 = ir.create(attributes_2)

    assert_equal item_1, ir.find_by_name('Pencil')
    assert_equal item_2, ir.find_by_name('Pen')
  end

  def test_it_returns_nil_if_item_name_is_not_present
    se = SalesEngine.from_csv({
      :items => "./data/item_sample.csv",
      :merchants => "./data/merchant_sample.csv"
    })
    ir = se.items
    attributes_1 = {
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now
    }
    item_1 = ir.create(attributes_1)
    attributes_2 = {
      :name        => "Pen",
      :description => "You can use it to write other things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now
    }
    item_2 = ir.create(attributes_2)

    assert_nil ir.find_by_name('Marker')
  end




end

  # def test_find_all_with_description
  #   se = SalesEngine.from_csv({
  #     :items => "./data/item_sample.csv",
  #     :merchants => "./data/merchant_sample.csv"
  #   })
  #   ir = se.items
  #   attributes_1 = {
  #     :name        => "Pencil",
  #     :description => "You can use it to write things",
  #     :unit_price  => BigDecimal.new(10.99,4),
  #     :created_at  => Time.now,
  #     :updated_at  => Time.now
  #   }
  #   item_1 = ir.create(attributes_1)
  #   attributes_2 = {
  #     :name        => "Pen",
  #     :description => "You can use it to write other things",
  #     :unit_price  => BigDecimal.new(10.99,4),
  #     :created_at  => Time.now,
  #     :updated_at  => Time.now
  #   }
  #   item_2 = ir.create(attributes_2)
  #
  #   assert_equal item_1, ir.find_all_with_description
  #   assert_equal item_2, ir.find_all_with_description
  # end
  #
  # def test_find_all_by_price
  #   se = SalesEngine.from_csv({
  #     :items => "./data/item_sample.csv",
  #     :merchants => "./data/merchant_sample.csv"
  #   })
  #   ir = se.items
  #   attributes_1 = {
  #     :name        => "Pencil",
  #     :description => "You can use it to write things",
  #     :unit_price  => BigDecimal.new(10.99,4),
  #     :created_at  => Time.now,
  #     :updated_at  => Time.now
  #   }
  #   item_1 = ir.create(attributes_1)
  #   attributes_2 = {
  #     :name        => "Pen",
  #     :description => "You can use it to write other things",
  #     :unit_price  => BigDecimal.new(10.99,4),
  #     :created_at  => Time.now,
  #     :updated_at  => Time.now
  #   }
  #   item_2 = ir.create(attributes_2)
  #
  #   assert_equal item_1, ir.find_by_name('Pencil')
  #   assert_equal item_2, ir.find_by_name('Pen')
  # end
  #
  # def test_find_all_by_price_range
  #   se = SalesEngine.from_csv({
  #     :items => "./data/item_sample.csv",
  #     :merchants => "./data/merchant_sample.csv"
  #   })
  #   ir = se.items
  #   attributes_1 = {
  #     :name        => "Pencil",
  #     :description => "You can use it to write things",
  #     :unit_price  => BigDecimal.new(10.99,4),
  #     :created_at  => Time.now,
  #     :updated_at  => Time.now
  #   }
  #   item_1 = ir.create(attributes_1)
  #   attributes_2 = {
  #     :name        => "Pen",
  #     :description => "You can use it to write other things",
  #     :unit_price  => BigDecimal.new(10.99,4),
  #     :created_at  => Time.now,
  #     :updated_at  => Time.now
  #   }
  #   item_2 = ir.create(attributes_2)
  #
  #   assert_equal item_1, ir.find_by_name('Pencil')
  #   assert_equal item_2, ir.find_by_name('Pen')
  # end
  #
  # def test_find_all_by_merchant_id
  #   se = SalesEngine.from_csv({
  #     :items => "./data/item_sample.csv",
  #     :merchants => "./data/merchant_sample.csv"
  #   })
  #   ir = se.items
  #   attributes_1 = {
  #     :name        => "Pencil",
  #     :description => "You can use it to write things",
  #     :unit_price  => BigDecimal.new(10.99,4),
  #     :created_at  => Time.now,
  #     :updated_at  => Time.now
  #   }
  #   item_1 = ir.create(attributes_1)
  #   attributes_2 = {
  #     :name        => "Pen",
  #     :description => "You can use it to write other things",
  #     :unit_price  => BigDecimal.new(10.99,4),
  #     :created_at  => Time.now,
  #     :updated_at  => Time.now
  #   }
  #   item_2 = ir.create(attributes_2)
  #
  #   assert_equal item_1, ir.find_by_name('Pencil')
  #   assert_equal item_2, ir.find_by_name('Pen')
  # end
