require_relative 'test_helper'
require './lib/sales_analyst'

class SalesAnalystTest < Minitest::Test

  def setup
    item_file_path = './test/fixtures/items_truncated.csv'
    merchant_file_path = './test/fixtures/merchants_truncated.csv'
    @engine = SalesEngine.new(item_file_path, merchant_file_path)
    @analyst = SalesAnalyst.new(@engine)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @analyst
    assert_instance_of SalesEngine, @engine
  end

  def test_item_count_returns_total_number_of_items
    repo = @engine.merchants

    assert_equal 3, @analyst.total_item_count_per_merchant(repo)
  end

  def test_average_items_per_merchant_returns_decimal_mean
    assert_equal 0.75, @analyst.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation_returns_deviation_from_mean

  end


end
