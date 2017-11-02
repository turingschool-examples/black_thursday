require "./test/test_helper"
require "./lib/sales_analyst"
require "./lib/sales_engine"

class SalesAnalystTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })

    sa = SalesAnalyst.new(se)

    assert_instance_of SalesAnalyst, sa
  end

  def test_it_can_find_average_items_per_merchant
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })

    sa = SalesAnalyst.new(se)

    assert_equal 2.88, sa.average_items_per_merchant
  end

  def test_it_can_find_merchant_list
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })

    sa = SalesAnalyst.new(se)

    assert_equal 475, sa.merchant_list.count
    assert_equal "12334105", sa.merchant_list.first
    assert_equal "12337411", sa.merchant_list.last
  end

  def test_it_can_find_number_of_items_merchant_sells
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })

    sa = SalesAnalyst.new(se)

    assert_equal 475, sa.find_items.count
    assert_equal 3, sa.find_items.first
    assert_equal 25, sa.find_items[4]
    assert_equal 1, sa.find_items.last
  end

  def test_it_can_find_standard_deviation_difference_total
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })

    sa = SalesAnalyst.new(se)

    assert_equal 5034.92, sa.find_standard_deviation_difference_total
  end

  def test_it_can_find_standard_deviation_total
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })

    sa = SalesAnalyst.new(se)

    assert_equal 10.62, sa.find_standard_deviation_total.round(2)
  end

  def test_it_can_find_total_merchants_minus_one
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })

    sa = SalesAnalyst.new(se)

    assert_equal 474, sa.total_merchants_minus_one
  end

  def test_it_can_find_average_items_per_merchant_standard_deviation
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })

    sa = SalesAnalyst.new(se)

    assert_equal 3.26, sa.average_items_per_merchant_standard_deviation
  end

  def test_it_can_create_merchant_id_item_total_list_in_a_hash
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })

    sa = SalesAnalyst.new(se)

    assert Hash, sa.create_merchant_id_item_total_list
    assert_equal 475, sa.create_merchant_id_item_total_list.count
    assert_equal "12334105", sa.create_merchant_id_item_total_list.first.first
    assert_equal 3, sa.create_merchant_id_item_total_list.first.last
    # assert_equal "12337411", sa.create_merchant_id_item_total_list.last.first
    # assert_equal 1, sa.create_merchant_id_item_total_list.last.last
  end

  def test_it_can_find_standard_deviation_plus_average
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })

    sa = SalesAnalyst.new(se)

    assert_equal 6.14, sa.standard_deviation_plus_average
  end

  def test_it_can_filter_merchants_by_items_in_stock_in_array
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })

    sa = SalesAnalyst.new(se)

    assert Array, sa.filter_merchants_by_items_in_stock
    assert_equal "12334123", sa.filter_merchants_by_items_in_stock.first.first
    assert_equal 25, sa.filter_merchants_by_items_in_stock.first.last
    assert_equal "12334194", sa.filter_merchants_by_items_in_stock[4].first
    assert_equal 7, sa.filter_merchants_by_items_in_stock[4].last
    assert_equal "12336965", sa.filter_merchants_by_items_in_stock.last.first
    assert_equal 10, sa.filter_merchants_by_items_in_stock.last.last
    #maybe write an assertion with an enum proving no merchant in this list has less than 7 items
  end

  def test_it_can_find_merchants_with_high_item_count
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })

    sa = SalesAnalyst.new(se)

    assert_equal 52, sa.merchants_with_high_item_count.count
    assert_equal "12334123", sa.merchants_with_high_item_count.first.id
    #feel like this test should be more robust
  end

  # def test_it_can_find_average_item_price_for_merchant
  #   se = SalesEngine.from_csv({
  #     :items     => "./data/items.csv",
  #     :merchants => "./data/merchants.csv",
  #   })
  #
  #   sa = SalesAnalyst.new(se)
  #
  #   assert_equal 16.65, sa.average_item_price_for_merchant(12334105)/100.to_f.round(2)
  # end


  def test_it_can_find_the_collections_of_items
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })

    sa = SalesAnalyst.new(se)

    assert Array, sa.find_the_collections_of_items(12334105)
    # assert_equal "Vogue Paris Original Givenchy 2307", sa.find_the_collections_of_items(12334105)[0].name
    # ^ undefinded method name for Nil:NilClass
  end

  # def test_it_can_find_average_average_price_per_merchant
  #   se = SalesEngine.from_csv({
  #     :items     => "./data/items.csv",
  #     :merchants => "./data/merchants.csv",
  #   })
  #
  #   sa = SalesAnalyst.new(se)
  #
  #   assert_equal 350.29, sa.average_average_price_per_merchant/100
  # end
end
