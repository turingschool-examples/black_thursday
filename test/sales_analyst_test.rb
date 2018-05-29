require './test/test_helper.rb'
require './lib/sales_analyst.rb'

class SalesAnalystTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
    merchants = se.load_file(se.content[:merchants])
    items = se.load_file(se.content[:items])
    @mr = MerchantRepository.new(merchants)
    @ir = ItemRepository.new(items)
    @sa = SalesAnalyst.new(@ir, @mr)
  end

  def test_it_exists
    skip
    assert_instance_of SalesAnalyst, @sa
  end

  def test_it_finds_all_merchant_ids
    skip
    assert_equal @ir.all.length, @sa.merchant_ids.length
    assert_equal @ir.all[0].merchant_id, @sa.merchant_ids[0]
    assert_equal @ir.all[235].merchant_id, @sa.merchant_ids[235]
  end

  def test_it_can_find_the_items_per_merchant
    skip
    first_id = @ir.all[0].merchant_id
    second_id = @ir.all[1].merchant_id
    assert_equal @sa.merchant_ids.count(first_id), @sa.items_per_merchant[0]
    assert_equal @sa.merchant_ids.count(second_id), @sa.items_per_merchant[1]
  end

  def test_analyst_can_check_average_items_per_merchant
    skip
    assert_equal 2.88, @sa.average_items_per_merchant
  end

  def test_can_find_the_standard_deviation_for_average_items_per_merchant
    skip
    assert_equal 3.26, @sa.average_items_per_merchant_standard_deviation
  end

  def test_it_can_find_merchants_offering_high_item_count
    skip
    assert_equal 52, @sa.merchants_with_high_item_count.length
    assert_instance_of Merchant, @sa.merchants_with_high_item_count.first
  end

  def test_it_can_find_average_item_price_per_merchant
    skip
    #needs to be a BigDecimal class, I changed this for the moment
    merchant_id = 12334105
    assert_equal 16.66, @sa.average_item_price_for_merchant(12334105)
  end

  def test_it_can_find_average_average_item_price_per_merchant
    skip
    #not returning a BigDecimal due to change in average_item_price_for_merchant
    assert_equal 350.29, @sa.average_average_price_per_merchant
  end

  def test_it_can_find_the_price_standard_deviation
    skip
    assert_equal '', @sa.item_price_standard_deviation
  end

  def test_it_can_find_all_golden_items
    assert_equal 5, @sa.golden_items.length
    assert_equal Item, @sa.golden_items.first.class
  end

end
