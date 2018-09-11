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

  def test_it_can_create_an_array_of_values
    # Lets wait to see if this is useful in the other iterations
  end

  def test_it_can_sum_values
    assert_equal 10.0, @sa_csv.sum([1, 2, 3, 4])
  end

  def test_it_can_average_an_array_of_values
    vals = [1, 2, 3, 4, 5]
    assert_equal 3.to_f, @sa_csv.average(vals)
  end

  def test_it_does_standard_deviation
    vals = [1.0, 2.0, 3.0, 4.0, 5.0]
    sum = vals.inject(0) { |sum, val| sum += val }
    mean = sum / (vals.count).to_f
    assert_equal 1.58, @sa_csv.standard_deviation(vals, mean)
  end


  # --- Item Repo Analysis Methods ---

  # TO DO - TEST ME
  # def merchant_stores

  # TO DO - TEST ME
  # def merchant_store_item_counts(groups)


  def test_it_gets_average_items_per_merchant
    assert_equal 2.88, @sa_csv.average_items_per_merchant
  end

  def test_it_gets_items_per_merchant_standard_deviation
    actual = @sa_csv.average_items_per_merchant_standard_deviation
    assert_equal 3.26, actual
  end

  def test_it_can_find_merchants_with_item_content_greater_than_one_std
    sellers = @sa_csv.merchants_with_high_item_count
    assert_instance_of Array, sellers
    assert_instance_of Merchant, sellers[0]
    # TO DO
    # FINDER MODULE!  -- use the merchant id to ensure 1st, 10th 30th all have more than one std value of items
  end




end
