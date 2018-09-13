require 'pry'
require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'time'
require 'bigdecimal'
require_relative '../lib/sales_engine'
require_relative '../lib/csv_adaptor'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repo'
require_relative '../lib/item'
require_relative '../lib/item_repo'

class ItemRepoTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.from_csv({
      :items     => "./data/sample_item_data.csv",
      :merchants => "./data/sample_merchant_file.csv"
    })
    ir = se.items

    assert_instance_of ItemRepo, ir
  end

  def test_all_item_characteristics_imports_item_objects_into_items_array
    se = SalesEngine.from_csv({
      :items     => "./data/sample_item_data.csv",
      :merchants => "./data/sample_merchant_file.csv"
    })
    ir = se.items

    assert_instance_of Array, ir.all
  end

  def test_all_returns_array_of_item_objects
    se = SalesEngine.from_csv({
      :items     => "./data/sample_item_data.csv",
      :merchants => "./data/sample_merchant_file.csv"
    })
    ir = se.items

    assert_instance_of Item, ir.items[1]
  end

  def test_find_by_id_returns_item_object_with_that_id
    se = SalesEngine.from_csv({
      :items     => "./data/sample_item_data.csv",
      :merchants => "./data/sample_merchant_file.csv"
    })
    ir = se.items
    id = 4378423
    expected = ir.all[1]

    assert_equal expected, ir.find_by_id(id)
  end

  def test_find_by_name_returns_item_object
    se = SalesEngine.from_csv({
      :items     => "./data/sample_item_data.csv",
      :merchants => "./data/sample_merchant_file.csv"
    })
    ir = se.items
    name = "test3"
    expected = ir.all[2]
    # want to write better test to ensure method is working - create custom csv

    assert_equal expected, ir.find_by_name(name)
  end

  def test_find_all_with_description_returns_items_with_description_fragment
    se = SalesEngine.from_csv({
      :items     => "./data/sample_item_data.csv",
      :merchants => "./data/sample_merchant_file.csv"
    })
    ir = se.items
    description = "description2"
    # want to write better test to ensure method is working - create custom csv

    assert_instance_of Array, ir.find_all_with_description(description)
  end


  def test_find_all_by_price_returns_array_of_matching_items_by_price
    se = SalesEngine.from_csv({
      :items     => "./data/sample_item_data.csv",
      :merchants => "./data/sample_merchant_file.csv"
    })
    ir = se.items
    # want to write better test to ensure method is working - create custom csv
    assert_equal 3, ir.find_all_by_price(125).count
  end

  def test_find_all_by_price_returns_array_of_matching_items_by_price
    se = SalesEngine.from_csv({
      :items     => "./data/sample_item_data.csv",
      :merchants => "./data/sample_merchant_file.csv"
    })
    ir = se.items
    # want to write better test to ensure method is working - create custom csv
    assert_equal [], ir.find_all_by_price(0)
  end

  def test_find_all_by_price_in_range_returns_array_of_items_in_range
    se = SalesEngine.from_csv({
      :items     => "./data/sample_item_data.csv",
      :merchants => "./data/sample_merchant_file.csv"
    })
    ir = se.items
    range = (0..100)
    ir.find_all_by_price_in_range(range)
    # want to write better test to ensure method is working - create custom csv

    assert_equal 8, ir.find_all_by_price_in_range(range).count
  end

  def test_find_all_by_merchant_id_returns_array_of_matching_items_by_merchant_id
    se = SalesEngine.from_csv({
      :items     => "./data/sample_item_data.csv",
      :merchants => "./data/sample_merchant_file.csv"
    })
    ir = se.items
    merchant_id = "1233400"
    # want to write better test to ensure method is working - create custom csv
    assert_equal 3, ir.find_all_by_merchant_id(merchant_id).count
  end

  def test_find_highest_item_id
    se = SalesEngine.from_csv({
      :items     => "./data/sample_item_data.csv",
      :merchants => "./data/sample_merchant_file.csv"
    })
    ir = se.items

    assert_equal 372872193712983129, ir.find_highest_item_id
  end

  def test_create_creates_new_instance_of_item
    se = SalesEngine.from_csv({
      :items     => "./data/sample_item_data.csv",
      :merchants => "./data/sample_merchant_file.csv"
    })
    ir = se.items
    attributes = {name: "TEST_ITEM", created_at: "2018-09-08", merchant_id: 5, unit_price: 1000}
    assert_instance_of Item, ir.create(attributes)
    assert_equal 372872193712983130, ir.create(attributes).id
  end

  def test_update_will_update_name_description_unit_price_and_updated_at_attributes
    se = SalesEngine.from_csv({
      :items     => "./data/sample_item_data.csv",
      :merchants => "./data/sample_merchant_file.csv"
    })
    ir = se.items
    id = 4378423
    attributes = {name: "TEST_ITEM", description: "Test Description", unit_price: 10}
    ir.update(id, attributes)

    assert_equal "TEST_ITEM", ir.update(id, attributes).name
    assert_equal "Test Description", ir.update(id, attributes).description
    assert_equal 10, ir.update(id, attributes).unit_price
  end

  def test_delete_id_deletes_item_object_from_items_array
    se = SalesEngine.from_csv({
      :items     => "./data/sample_item_data.csv",
      :merchants => "./data/sample_merchant_file.csv"
    })
    ir = se.items
    item = ir.find_by_id(4378423)
    ir.delete(4378423)

    refute ir.items.include?(item)
  end

end
