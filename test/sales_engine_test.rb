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

class SalesEngineTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.new("file1", "file2")

    assert_instance_of SalesEngine, se
  end

  def test_it_has_attributes
    se = SalesEngine.new("file1", "file2")

    assert_equal "file1", se.item_file
    assert_equal "file2", se.merchant_file
  end

  def test_merchants_and_items_creates_instances_of_repos
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv"
    })

    assert_instance_of MerchantRepo, se.merchants
    assert_instance_of ItemRepo, se.items
  end

end
