require './test/test_helper'

class MerchantRepositoryTest < Minitest::Test

  def test_all_merchants_are_present
    assert_equal 5, @engine.merchants.all.count
    assert_equal "Shopin1901", @engine.merchants.all.first.merchant_data['name']
    assert_equal "GoldenRayPress", @engine.merchants.all.last.merchant_data['name']
  end

  def test_find_by_id
    merchant = @engine.merchants.find_by_id(12334113)
    assert_equal 'MiniatureBikez', merchant.name
  end

  def test_find_by_id_nil
    merchant = @engine.merchants.find_by_id(57396729)
    assert_equal nil, merchant
  end

  def test_find_by_name
    merchant = @engine.merchants.find_by_name("Candisart")
    assert_equal "Candisart", merchant.name
  end

  def test_find_by_name_nil
    merchant = @engine.merchants.find_by_name("Lane")
    assert_equal nil, merchant
  end

  def test_find_all_by_name
    merchant_array = @engine.merchants.find_all_by_name("ol")
    merchant_array = merchant_array.map {|merchant| merchant.name}
    assert_equal ['LolaMarleys', 'GoldenRayPress'], merchant_array
  end

  def test_find_all_by_name_empty
    merchant = @engine.merchants.find_all_by_name("Lane")
    assert_equal [], merchant
  end
end
