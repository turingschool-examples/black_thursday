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

  def test_it_gets_attrubutes
    # -- Sales Engine --
    assert_instance_of SalesEngine, @sa_csv.engine
    # ==== REPOs ====
    # NOTE - Instance vars for repos are the arrays
    # held within the repos, not the repos themselves.
    # -- Merchant --
    assert_instance_of Array, @sa_csv.merchants
    assert_instance_of Merchant, @sa_csv.merchants[0]
    # -- Item --
    assert_instance_of Array, @sa_csv.items
    assert_instance_of Item, @sa_csv.items[0]
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

  def test_it_can_sum_values
    assert_equal 10.0, @sa_csv.sum([1, 2, 3, 4])
  end

  def test_it_can_average_an_array_of_values
    vals = [1, 2, 3, 4, 5]
    assert_equal 3.to_f, @sa_csv.average(vals)
  end

  def test_it_does_standard_deviation
    # vals = [1.0, 2.0, 3.0, 4.0, 5.0]
    # TO DO - HARDCODE more of this here (less calculations)
    # mean = (15.0 / 5.0).round(2)   # merchant average is rounded 2
    # squares = [4.0, 1.0, 0.0, 1.0, 4.0]
    # sq_sum = 10.0
    # # sq_sum = vals.inject(0) {|tot, val| tot += val }
    # av = sq_sum / (5-1).to_f
    # std = Math.sqrt(av).round(2)

    # mean = 3.00     # merchant average is rounded 2
    skip
    values = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]
    sum    = values.inject(0){ |sum, val| sum + val }
    ct     = values.count
    mean   = (sum / ct.to_f) #.round(2)
    val1 = (1.0-mean)**2 ; val2 = (2.0-mean)**2
    val3 = (3.0-mean)**2 ; val4 = (4.0-mean)**2
    val5 = (5.0-mean)**2 ; val6 = (6.0-mean)**2
    val7 = (7.0-mean)**2 ; val8 = (8.0-mean)**2
    sq_sum = val1 + val2 + val3 + val4 + val5 + val6 + val7 + val8

    ct             = 8
    sq_mean        = (sq_sum / ct.to_f).round(2)
    std            = Math.sqrt(sq_mean).round(2)
    assert_equal std, @sa_csv.standard_deviation(values, mean)

    skip
    # sample_ct      = ct - 1
    # sample_average = (sq_sum / sample_ct.to_f).round(2)
    sample_average = (sq_sum / ct.to_f).round(2)
    sample_std     = Math.sqrt(average).round(2)
    assert_equal sample_std, @sa_csv.standard_deviation(values, mean)

  end


  # --- Merchant Methods ---

  def test_it_gets_average_items_per_merchant
    assert_equal 2.88, @sa_csv.average_items_per_merchant
  end

  def test_it_gets_items_per_merchant_standard_deviation
    actual = @sa_csv.average_items_per_merchant_standard_deviation
    assert_equal 3.26, actual
  end




end
