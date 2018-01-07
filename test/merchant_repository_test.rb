require_relative 'test_helper'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < MiniTest::Test
  def setup
    @se = mock('sales_engine')
    file_path = './test/fixtures/merchants_truncated.csv'
    @mr = MerchantRepository.new(file_path, @se)
  end

  def test_all_returns_an_array_of_merchant_instances
    result = @mr.all

    assert result.all? do |element|
      element.class == Merchant
    end
  end

  def test_find_by_id_returns_nil_if_merchant_does_not_exist
    assert_nil @mr.find_by_id(789)
  end

  def test_find_by_id_returns_merchant_instance_with_matching_id
    result = @mr.find_by_id(12334113)

    assert_equal 12334113, result.id
    assert_instance_of Merchant, result
  end

  def test_find_by_name_returns_nil_if_merchant_does_not_exist
    assert_nil @mr.find_by_name('bill robbins')
  end

  def test_find_by_name_returns_merchant_instance_with_matching_name
    result = @mr.find_by_name('LolaMarleys')

    assert_equal 'LolaMarleys', result.name
    assert_instance_of Merchant, result
  end

  def test_find_by_name_returns_merchant_instance_with_matching_name_case_insensitive
    result = @mr.find_by_name('lolamarleys')

    assert_equal 'LolaMarleys', result.name
  end

  def test_it_returns_all_merchants_with_a_matching_name_fragment
    name = 'BowlsBy'

    result = @mr.find_all_by_name(name).map do |merchant|
      merchant.name
    end

    assert_equal ['BowlsByChris', 'BowlsByAnna'], result
  end

  def test_it_returns_an_empty_array_if_no_merchants_match_name
    result = @mr.find_all_by_name('name')

    assert result.empty?
  end

  def test_it_finds_average_item_price_for_merchant
    item_1 = stub(:unit_price => 29.99)
    item_2 = stub(:unit_price => 9.99)
    item_3 = stub(:unit_price => 9.99)
    @se.stubs(:find_items_by_merchant_id).returns([item_1, item_2, item_3])

    assert_equal 16.656666666666666, @mr.find_average_item_price_for_merchant(12334105)
  end

  def test_it_calls_sales_engine_to_return_items_by_merchant_id
    item = mock('item')
    @se.expects(:find_items_by_merchant_id).returns([item, item, item])

    assert_equal [item, item, item], @mr.find_items_by_id(12334105)
  end

end
