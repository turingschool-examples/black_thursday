require_relative './test_helper'

class SalesAnalystTest < Minitest::Test

  def setup
    @sales_engine = SalesEngine.from_csv({
    :items     => "./data/item_test.csv",
    :merchants => "./data/merchant_test.csv",
    })
    @sales_analyst = @sales_engine.analyst
    @merchant_1 = @sales_engine.merchants.all[0]
    @merchant_2 = @sales_engine.merchants.all[1]
    @merchant_3 = @sales_engine.merchants.all[2]
    @merchant_4 = @sales_engine.merchants.all[3]
    @merchant_5 = @sales_engine.merchants.all[4]
  end

  def test_it_exists
    sales_analyst = SalesAnalyst.new(@sales_engine)
    assert_instance_of SalesAnalyst, sales_analyst
  end

  def test_it_can_be_created_by_sales_engine
    sales_analyst = @sales_engine.analyst
    assert_instance_of SalesAnalyst, sales_analyst
  end


  def test_it_can_generate_all_merchants
    merchants = @sales_engine.merchants

    assert_instance_of MerchantRepository, merchants
  end

  def test_it_can_count_merchants
    merchants = @sales_engine.merchants

    assert_equal 5, merchants.all.size
  end

  def test_it_can_generate_all_items
    items = @sales_engine.items

    assert_instance_of ItemRepository, items
  end

  def test_it_can_count_items
    items = @sales_engine.items

    assert_equal 3, items.all.size
  end

  def test_it_can_generate_all_merchants
    merchants = @sales_engine.merchants
    ids = merchants.all.map do |merchant|
      merchant.id
    end

    assert_equal 12334105, ids[0]
  end

  def test_it_can_group_items_by_merchant_id_for_avg
    items = @sales_engine.items

    assert_equal 2, items.find_all_by_merchant_id(12334185).size
    assert_equal 1, items.find_all_by_merchant_id(12334105).size
  end

  def test_it_can_calculate_the_average_number_of_items_per_merchant
    sales_analyst = SalesAnalyst.new(@sales_engine)
    items = @sales_engine.items
    merchants = @sales_engine.merchants
    # merchants.all.each do |merchant|
    #   << items.find_all_by_merchant_id(merchant)
    # end

    assert_equal 0.2, sales_analyst.average_items_per_merchant
  end

  def test_analyst_can_find_which_merchant_sells_the_most
    assert_equal [@merchant_1], @sales_analyst.merchants_with_high_item_count
  end

  def test_it_can_average_price_of_items_by_merchant
    sa = @sales_engine.analyst
    average = sa.average_item_price_for_merchant(12334185)

    assert_equal 0, average
  end

  def test_it_can_calculate_mean
    array = [1, 2, 3, 4]

    assert_equal 2.5, @sales_analyst.mean(array)
  end

  def test_it_can_calulate_sum
    array = [1, 2, 3, 4]

    assert_equal 10, @sales_analyst.sum(array)
  end

  def test_it_can_calculate_std_deviation
    array = [1, 2, 3, 4]

    assert_equal 1.29, @sales_analyst.std_dev(array)
  end

  def test_it_returns_num_items_per_merchant
    expected = {@merchant_1 => 1, @merchant_2 => 0, @merchant_3 => 0,
                @merchant_4 => 0, @merchant_5 => 0}
    assert_equal expected, @sales_analyst.num_items_for_each_merchant
  end

  def test_it_can_calculate_average_items_per_merchant_std_deviation
    assert_equal 0.45, @sales_analyst.average_items_per_merchant_standard_deviation
  end
  

end
