require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test

  attr_reader :merch_repo, :se, :sa

  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/small_items.csv",
      :merchants => "./data/small_merchants.csv",})
    @sa = SalesAnalyst.new(se)

    #replaced by hard coded data vs loading csv:
    # @se.items
    # @merch_repo = @se.merchants

    @se.merchant_repo = MerchantRepository.new(nil, se)
    @se.item_repo = ItemRepository.new(nil, se)

    @se.merchant_repo.add_new({:id => 1, :name => "Merch1"}, @se)
    @se.merchant_repo.add_new({:id => 2, :name => "Merch2"}, @se)
    @se.merchant_repo.add_new({:id => 3, :name => "Merch3"}, @se)

    @se.item_repo.add_new({:id => 1, :name => "Item1", :unit_price => 200, :merchant_id => 1}, @se)
    @se.item_repo.add_new({:id => 2, :name => "Item2", :unit_price => 100, :merchant_id => 1}, @se)

    @se.item_repo.add_new({:id => 3, :name => "Item3", :unit_price => 100, :merchant_id => 2}, @se)

    @se.item_repo.add_new({:id => 4, :name => "Item4", :unit_price => 500, :merchant_id => 3}, @se)
    @se.item_repo.add_new({:id => 5, :name => "Item5", :unit_price => 1000, :merchant_id => 3}, @se)
    @se.item_repo.add_new({:id => 6, :name => "Item6", :unit_price => 3000, :merchant_id => 3}, @se)
    @se.item_repo.add_new({:id => 7, :name => "Item7", :unit_price => 1250, :merchant_id => 3}, @se)

  end


  def test_average_items_per_merchant_gives_correct_average
    assert_equal 2.33, sa.average_items_per_merchant
  end

  def test_sum_will_sum_array_correctly
    assert_equal 6, sa.sum([1,2,3])
  end

  def test_average_an_array_is_correct
    assert_equal 2, sa.average([1,2,3])
  end

  def test_standard_deviation_works_on_an_array
    assert_equal 1.0, sa.standard_deviation([1,2,3])
    assert_equal 2.65, sa.standard_deviation([1,2,6])
  end

  def test_generates_array_of_item_counts_per_merchant
    assert_equal  [1, 2, 4], sa.item_count_by_merchant
  end

  def test_calculates_std_dev_of_item_counts
    assert_equal 1.53, sa.average_items_per_merchant_standard_deviation
  end

  def test_identifes_all_merchants_with_high_item_counts
    assert_equal 1, sa.merchants_with_high_item_count.length
  end

  def test_identifes_correct_merchants_with_high_item_counts
    assert_equal 3, sa.merchants_with_high_item_count[0].id
  end

  def test_identifies_average_item_price_for_merchant
    assert_equal  14.38, sa.average_item_price_for_merchant(3)
  end

  def test_identifies_average_item_price_for_merchant_as_BD
    assert_equal  BigDecimal, sa.average_item_price_for_merchant(3).class
  end

  def test_identifies_avg_avg_price_per_merchant_as_BD
    assert_equal  BigDecimal, sa.average_average_price_per_merchant.class
  end

  def test_identifies_avg_avg_price_for_merchant
    assert_equal  5.63, sa.average_average_price_per_merchant.to_f
  end

  def test_generates_array_of_item_prices
    sorted = [1.0, 1.0, 2.0, 5.0, 10.0, 12.5, 30.0]
    assert_equal  sorted, sa.item_price_array
  end

  def test_calculates_std_dev_of_item_prices
    assert_equal 10.38, sa.item_price_standard_deviation
  end

  def test_average_item_price
    assert_equal 8.79, sa.item_price_average
  end

  def test_identifes_all_golden_items
    assert_equal 1, sa.golden_items.length
  end

  def test_identifes_correct_golden_item
    assert_equal 6, sa.golden_items[0].id
  end


  # def test_average_items_per_merchant_gives_correct_average
  #   assert_equal 1.90, sa.average_items_per_merchant
  # end
  #
  # def test_generates_array_of_item_counts_per_merchant
  #   assert_equal  [1, 1, 1, 1, 1, 1, 2, 2, 3, 6], sa.item_count_by_merchant
  # end
  #
  # def test_calculates_std_dev_of_item_counts
  #   assert_equal 1.60, sa.average_items_per_merchant_standard_deviation
  # end
  #
  # def test_identifes_all_merchants_with_high_item_counts
  #   assert_equal 1, sa.merchants_with_high_item_count.length
  # end
  #
  # def test_identifes_correct_merchants_with_high_item_counts
  #   assert_equal 12334185, sa.merchants_with_high_item_count[0].id
  # end
  #
  # def test_identifies_average_item_price_for_merchant
  #   assert_equal  50.0, sa.average_item_price_for_merchant(12334144)
  # end
  #
  # def test_identifies_average_item_price_for_merchant_as_BD
  #   assert_equal  BigDecimal, sa.average_item_price_for_merchant(12334144).class
  # end
  #
  # def test_identifies_avg_avg_price_per_merchant_as_BD
  #   assert_equal  BigDecimal, sa.average_average_price_per_merchant.class
  # end
  #
  # def test_identifies_avg_avg_price_for_merchant
  #   assert_equal  71.16, sa.average_average_price_per_merchant.to_f
  # end
  #
  # def test_generates_array_of_item_prices
  #   sorted = [3.99, 6.9, 7.0, 9.99, 13.0, 13.0, 14.0, 14.9, 20.0, 29.99, 35.0, 49.0, 75.0, 80.0, 120.0, 130.0, 149.0, 150.0, 400.0]
  #   assert_equal  sorted, sa.item_price_array
  # end
  #
  # def test_calculates_std_dev_of_item_prices
  #   assert_equal 94.90, sa.item_price_standard_deviation
  # end
  #
  # def test_average_item_price
  #   assert_equal 69.51, sa.item_price_average
  # end
  #
  # def test_identifes_all_golden_items
  #   assert_equal 1, sa.golden_items.length
  # end
  #
  # def test_identifes_correct_golden_item
  #   assert_equal 263396517, sa.golden_items[0].id
  # end

end
