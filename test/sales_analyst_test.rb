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
    
    # @merchant_1 = Merchant.new({id: 5, name: 'Steve'})
    # @merchant_2 = Merchant.new({id: 10, name: 'Turing School'})
    # @merchant_3 = Merchant.new({id: 7, name: 'Turk'})
    # @merchants = [@merchant_1, @merchant_2, @merchant_3]
    # @mr = MerchantRepository.new(@merchants)
    
    # @time = Time.now
    # @item_1 = Item.new({
    #           :id          => 1,
    #           :name        => "Pencil",
    #           :description => "You can use it to write things",
    #           :unit_price  => BigDecimal.new(10.99,4),
    #           :created_at  => @time, 
    #           :updated_at  => @time, 
    #           :merchant_id => 10
    #         })
    # @item_2 = Item.new({
    #           :id          => 2,
    #           :name        => "Pen",
    #           :description => "You can use it to write things in ink!",
    #           :unit_price  => BigDecimal.new(32.99,4),
    #           :created_at  => @time
    #           :updated_at  => @time
    #           :merchant_id => 10
    #         })
    # @item_3 = Item.new({
    #           :id          => 3,
    #           :name        => "Glitter Scrabble",
    #           :description => "Why wouldn't you want glitter on your scrabble",
    #           :unit_price  => BigDecimal.new(49.99,4),
    #           :created_at  => @time
    #           :updated_at  => @time
    #           :merchant_id => 5
    #         })
    # @item_4 = Item.new({
    #           :id          => 4,
    #           :name        => "3-d printed Dinosaur",
    #           :description => "It's awesome",
    #           :unit_price  => BigDecimal.new(2.99,3),
    #           :created_at  => @time
    #           :updated_at  => @time
    #           :merchant_id => 5
    #         })
    # @item_5 = Item.new({
    #           :id          => 5,
    #           :name        => "Passing RSpec harness",
    #           :description => "You know you want it",
    #           :unit_price  => BigDecimal.new(159.01,5),
    #           :created_at  => @time
    #           :updated_at  => @time
    #           :merchant_id => 7
    #         })
    # @items = [@item_1, @item_2, @item_3, @item_4, @item_5]
  end

  def test_it_exists
    sales_analyst = SalesAnalyst.new(@sales_engine)
    assert_instance_of SalesAnalyst, sales_analyst
  end

  def test_it_can_be_created_by_sales_engine
    sales_engine = SalesEngine.from_csv({
    :items     => "./data/item_test.csv",
    :merchants => "./data/merchant_test.csv",
    })
    sales_analyst = sales_engine.analyst
    assert_instance_of SalesAnalyst, sales_analyst
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
    # assert_equal 5, items.all.size
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
    # assert_equal 2, items.find_all_by_merchant_id(10).size
    # assert_equal 1, items.find_all_by_merchant_id(7).size
  end

  def test_it_can_calculate_the_average_number_of_items_per_merchant
    sales_analyst = SalesAnalyst.new(@sales_engine)
    items = @sales_engine.items
    merchants = @sales_engine.merchants

    assert_equal 0.2, sales_analyst.average_items_per_merchant
    # assert_equal 1.67, sales_analyst.average_items_per_merchant
  end

  def test_analyst_can_find_which_merchant_sells_the_most
    assert_equal [@merchant_1], @sales_analyst.merchants_with_high_item_count
    # expected = [@merchant_1, @merchant_2]
    # assert_equal expected, @sales_analyst.merchants_with_high_item_count
  end

  def test_it_can_average_price_of_items_by_merchant
    average_1 = @sales_analyst.average_item_price_for_merchant(12334185)
    average_2 = @sales_analyst.average_item_price_for_merchant(12334105)
    assert_equal 10.0, average_1
    assert_equal 29.99, average_2
    # average_1 = @sales_analyst.average_item_price_for_merchant(5)
    # average_2 = @sales_analyst.average_item_price_for_merchant(10)
    # assert_equal 26.49, average_1
    # assert_equal 21.99, average_2
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
    # expected = {@merchant_1 => 2, @merchant_2 => 2, @merchant_3 => 1}
    # assert_equal expected, @sales_analyst.num_items_for_each_merchant
  end

  def test_it_can_calculate_average_items_per_merchant_std_deviation
    assert_equal 0.45, @sales_analyst.average_items_per_merchant_standard_deviation
    # assert_equal 0.58, @sales_analyst.average_items_per_merchant_standard_deviation
  end
  
  def test_it_can_calculate_average_average_price_per_merchant
    assert_equal 6.00, @sales_analyst.average_average_price_per_merchant
    # assert_equal 71.0, @sales_analyst.average_average_price_per_merchant
  end
  
  def test_it_can_find_golden_items
    assert_equal [], @sales_analyst.golden_items
    # assert_equal ???, @sales_analyst.golden_items
  end

end
