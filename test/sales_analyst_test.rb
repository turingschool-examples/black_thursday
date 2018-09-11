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
require_relative '../lib/sales_analyst'

class SalesAnalystTest < MiniTest::Test
  def test_it_exists
    sales_engine = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv"
    })

    assert_instance_of SalesAnalyst, sales_engine.analyst
  end

  def test_average_items_per_merchant
    sales_engine = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv"
    })
    sales_analyst = sales_engine.analyst
    assert_equal 2.88, sales_analyst.average_items_per_merchant
  end

  def test_find_all_merchant_ids
    sales_engine = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv"
    })
    sales_analyst = sales_engine.analyst

    expected = sales_engine.merchants.all.count

    assert_equal expected, sales_analyst.find_all_merchant_ids.count
  end

  def test_find_number_item_objects_per_merchant
    sales_engine = SalesEngine.from_csv({
    :items     => "./data/sample_item_data.csv",
    :merchants => "./data/sample_merchant_file.csv"
    })
    sales_analyst = sales_engine.analyst
    assert_instance_of Hash, sales_analyst.find_item_object_per_merchant
  end

  def test_find_number_of_items_per_merchant
    sales_engine = SalesEngine.from_csv({
    :items     => "./data/sample_item_data.csv",
    :merchants => "./data/sample_merchant_file.csv"
    })
    sales_analyst = sales_engine.analyst

    assert_instance_of Array, sales_analyst.find_number_of_items_per_merchant
  end

  def test_find_standard_devation_step_one
    sales_engine = SalesEngine.from_csv({
    :items     => "./data/sample_item_data.csv",
    :merchants => "./data/sample_merchant_file.csv"
    })
    sales_analyst = sales_engine.analyst
    assert_instance_of Array, sales_analyst.find_standard_deviation_step_one
  end

  def test_find_standard_devation_step_two
    sales_engine = SalesEngine.from_csv({
    :items     => "./data/sample_item_data.csv",
    :merchants => "./data/sample_merchant_file.csv"
    })
    sales_analyst = sales_engine.analyst
    assert_instance_of Float, sales_analyst.find_standard_deviation_step_two
  end

  def test_find_standard_devation_step_three
    sales_engine = SalesEngine.from_csv({
    :items     => "./data/sample_item_data.csv",
    :merchants => "./data/sample_merchant_file.csv"
    })
    sales_analyst = sales_engine.analyst
    assert_instance_of Float, sales_analyst.find_standard_deviation_step_three
  end

  def test_find_standard_deviation
    skip
    sales_engine = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv"
    })
    sales_analyst = sales_engine.analyst

    assert_equal 3.26, sales_analyst.find_standard_deviation
  end

  def test_find_merchants_with_high_item_count
    sales_engine = SalesEngine.from_csv({
    :items     => "./data/sample_item_data.csv",
    :merchants => "./data/sample_merchant_file.csv"
    })
    sales_analyst = sales_engine.analyst

    assert_instance_of Hash, sales_analyst.merchant_and_item_count_hash

  end

  def test_find_merchant_ids_with_high_item_count
    sales_engine = SalesEngine.from_csv({
    :items     => "./data/sample_item_data.csv",
    :merchants => "./data/sample_merchant_file.csv"
    })
    sales_analyst = sales_engine.analyst

    assert_equal 1, sales_analyst.find_merchant_ids_with_high_item_count.length
  end

  def test_find_merchant_objects_with_high_item_count
    sales_engine = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv"
    })
    sales_analyst = sales_engine.analyst

    assert_instance_of Merchant, sales_analyst.find_merchant_objects_with_high_item_count[0]
  end

end
