require_relative 'test_helper'

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
    assert_instance_of MerchantRepository, @sa_csv.merchants
    assert_instance_of Merchant, @sa_csv.merchants.all[0]
    # -- Item --
    assert_instance_of ItemRepository, @sa_csv.items
    assert_instance_of Item, @sa_csv.items.all[0]
  end


  # --- General Methods ---

  def test_it_can_group_by_a_method_of_an_object_in_a_repo
    # From the getter methods of objects in the repo
    sample = @sa_csv.merchants.all.first(100)
    items = @sa_csv.items.all
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

  def test_it_creates_merchant_stores_by_id_and_item_collection
    qty_merch  = @sa_csv.merchants.all.count
    qty_stores = @sa_csv.merchant_stores.count
    assert_equal qty_merch, qty_stores
    assert_instance_of Hash, @sa_csv.merchant_stores
    assert_instance_of Array, @sa_csv.merchant_stores.values[0]
    assert_instance_of Item, @sa_csv.merchant_stores.values[0][0]
  end

  def test_it_can_create_an_array_of_the_counts_of_its_per_merchant
    groups = @sa_csv.merchant_stores
    values = @sa_csv.merchant_store_item_counts(groups)
    assert_instance_of Array, values
    qty_merch  = @sa_csv.merchants.all.count
    assert_equal qty_merch, values.count

    sum = values.inject(0) { |total, val| total += val}
    count = @sa_csv.items.all.count
    assert_equal count, sum
  end


  def test_it_gets_average_items_per_merchant
    assert_equal 2.88, @sa_csv.average_items_per_merchant
  end

  def test_it_gets_items_per_merchant_standard_deviation
    actual = @sa_csv.average_items_per_merchant_standard_deviation
    assert_equal 3.26, actual
  end

  # TO DO - FINDER MODULE!  -- use the merchant id to ensure 1st, 10th 30th all have more than one std value of items
  def test_it_can_find_merchants_with_item_content_greater_than_one_std
    sellers = @sa_csv.merchants_with_high_item_count
    assert_instance_of Array, sellers
    assert_instance_of Merchant, sellers[0]
  end

  # TO DO - TEST WHEN finder method is available
  def test_it_can_average_item_price_per_merchant
    skip
    id = 12334112
    av_price = @sa_csv.average_item_price_for_merchant(id)
    assert_equal ______, av_price
    assert_instance_of BigDecimal, av_price
  end

  # TO DO - TEST WHEN finder method is available
  def test_it_can_average_average_price_per_merchant
    skip
    av_price = @sa_csv.average_average_price_per_merchant
    assert_equal ____, av_price
    assert_instance_of BigDecimal, av_price
  end

  # TO DO - FINDER MODULE!  -- use the merchant id to ensure 1st, 10th 30th all have more than one std value of items
  def test_it_gets_golden_items
    items = @sa_csv.golden_items
    assert_instance_of Array, items
    assert_instance_of Item, items[0]
    assert_operator @sa_csv.items.all.count, :>, items.count
  end



end
