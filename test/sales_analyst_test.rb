require_relative './test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test
  def setup
    @engine = SalesEngine.from_csv({:items => './test/data/items.csv',
                                    :merchants => './test/data/merchants.csv'})

    @analyst = @engine.analyst
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @analyst
  end

  def test_it_has_an_engine
    assert_instance_of SalesEngine, @analyst.engine
  end

  def test_it_can_return_average_items_per_merchant
    actual = @analyst.average_items_per_merchant
    assert_instance_of Float, actual
    assert_equal 0.11, actual
  end

  def test_it_can_return_average_items_per_merchant_standard_deviation
    merch = stub('Merchant', id:1)
    merch_array = [merch]*5
    @engine.merchants.stubs(:all).returns(merch_array)
    @engine.items.stubs(:find_all_by_merchant_id).returns([0]*5, [0]*3,
                                                          [0]*6, [0]*2,
                                                          [0]*7)

    actual = @analyst.average_items_per_merchant_standard_deviation
    assert_equal 2.07, actual
  end

  def test_it_returns_merchants_with_high_item_counts
    merch1 = stub('Merchant', id: 1)
    merch2 = stub('Merchant', id: 2)
    merch3 = stub('Merchant', id: 3)
    merch_array = [merch1, merch2, merch3]

    items = stub('Item')
    item_array = [items]*105
    @engine.merchants.stubs(:all).returns(merch_array)
    @engine.items.stubs(:find_all_by_merchant_id).returns(
            [0] * 2, [0] * 3, [0] * 100,
            [0] * 2, [0] * 3, [0] * 100)

    actual = @analyst.merchants_with_high_item_count
    assert_equal [merch3], actual
  end

  def test_it_returns_average_item_price_for_merchant
    merch = stub('Merchant', id:1)
    item1 = stub('Item', unit_price: BigDecimal.new(25.00, 4))
    item2 = stub('Item', unit_price: BigDecimal.new(30.00, 4))
    item3 = stub('Item', unit_price: BigDecimal.new(5.00, 4))
    @engine.items.stubs(:find_all_by_merchant_id).with(1).returns([item1, item2, item3])
    assert_equal 20, @analyst.average_item_price_for_merchant(1)
  end

  def test_it_returns_average_average_price_per_merchant
    merch1 = stub('Merchant', id: 1)
    merch2 = stub('Merchant', id: 2)
    item1 = stub('Item', unit_price: BigDecimal.new(26.00, 4))
    item2 = stub('Item', unit_price: BigDecimal.new(10.00, 4))
    item3 = stub('Item', unit_price: BigDecimal.new(1.00, 4))
    item4 = stub('Item', unit_price: BigDecimal.new(2.00, 4))
    item5 = stub('Item', unit_price: BigDecimal.new(3.00, 4))

    @engine.merchants.stubs(:all).returns([merch1, merch2])
    @engine.items.stubs(:find_all_by_merchant_id).returns(
                        [item1, item2],[item3, item4, item5])

    assert_equal 10, @analyst.average_average_price_per_merchant
  end

  # FIXME: Fix this test tomorrow
  # def test_it_returns_golden_items
  #   item1 = stub('Item', unit_price: BigDecimal.new(200.00, 5))
  #   item2 = stub('Item', unit_price: BigDecimal.new(1.00, 3))
  #   item3 = stub('Item', unit_price: BigDecimal.new(1.10, 3))
  #   item4 = stub('Item', unit_price: BigDecimal.new(1.20, 3))
  #   item5 = stub('Item', unit_price: BigDecimal.new(1.30, 3))
  #   item5 = stub('Item', unit_price: BigDecimal.new(1.40, 3))
  #
  #   @engine.items.stubs(:all).returns(
  #                       [item1, item2, item3, item4, item5])
  #
  #   assert_equal [item1], @analyst.golden_items
  # end
end
