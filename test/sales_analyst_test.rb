# TO DO - Add these to simplecov
require 'minitest/autorun'
require 'minitest/pride'

require 'pry'

# TO DO  - change these to require require_relative
require './lib/item_repository'
require './lib/merchant_repository'
require './lib/sales_engine'
require './lib/sales_analyst'


class SalesAnalystTest < Minitest::Test

  # ================================
  def setup
    @hash = { :items     => "./data/items.csv",
              :merchants => "./data/merchants.csv",
            }
    # @se_new = SalesEngine.new
    @se_csv = SalesEngine.from_csv(@hash)

    # @sa_new = SalesAnalyst.new(@se_new)
    @sa_csv = SalesAnalyst.new(@se_csv)
  end
  # ================================


  def test_it_exists
    # assert_instance_of SalesAnalyst, @sa_new
    assert_instance_of SalesAnalyst, @sa_csv
  end


  # --- General Methods ---

  def test_it_can_group_by_a_method_of_an_object_in_a_repo
    # From the getter methods of objects in the repo
    sample = @sa_csv.merchants.first(100)
    items = @sa_csv.items
    actual = @sa_csv.group_by(items, :merchant_id )
    assert_operator 100, :<, actual.count
    assert_equal "12334141", actual.keys[0]
    assert_instance_of Array, actual.values[0]
    assert_equal "12334185", actual.keys[1]
    assert_instance_of Array, actual.values[1]
  end






  def test_it_does_standard_deviation
    vals = [1, 2, 3, 4, 5]
    # TO DO - HARDCODE more of this here (less calculations)
    mean = ((1 + 2 + 3 + 4 + 5) / 5).round(2)   # merchant average is rounded 2
    squares = vals.map { |val| (val - mean)**2 }
    sum = vals.inject(0) {|tot, val| tot += val }
    av = sum / (5-1)
    std = Math.sqrt(av).round(2)

    # mean = 3.00     # merchant average is rounded 2
    # val1 = (1-mean)**2 ; val2 = (2-mean)**2
    # val3 = (3-mean)**2 ; val4 = (4-mean)**2
    # val5 = (5-mean)**2
    # average = (val1 + val2 + val3 + val4 + val5) / 5.to_f
    # std = Math.sqrt(average).round(2)

    assert_equal std, @sa_csv.standard_deviation(vals, mean)
  end


  def test_it_gets_average_items_per_merchant
    assert_equal 2.88, @sa_csv.average_items_per_merchant
  end

  def test_it_gets_items_per_merchant_standard_deviation
    skip
    actual = @sa_csv.average_items_per_merchant_standard_deviation
    binding.pry
    assert_equal 3.26, actual
  end




end
