require_relative 'test_helper'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_engine'

class MerchantRepositoryTest < Minitest::Test
  def setup
    @csv_path = './test/fixtures/merchants_list_truncated.csv'
    @mr = MerchantRepository.new(@csv_path, 'parent')
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @mr
  end

  def test_for_initialized_arguments
    assert_equal @csv_path, @mr.merchant_csv_path
    assert_equal 'parent', @mr.parent
  end

  def test_for_all_method
    assert_instance_of Array, @mr.all
    assert @mr.all[0].is_a?(Merchant)
    assert_equal 22, @mr.all.count
  end

  def test_for_find_by_id_method
    assert_nil @mr.find_by_id('10101010')
    assert @mr.find_by_id(123_341_12).is_a?(Merchant)
    assert_equal 'Candisart', @mr.find_by_id(123_341_12).name
  end

  def test_for_find_by_name_method
    assert_nil @mr.find_by_name('Mesander')
    assert @mr.find_by_name('LolaMarleys').is_a?(Merchant)
    assert_equal 123_341_23, @mr.find_by_name('Keckenbauer').id
    assert @mr.find_by_name('lolamarleys').is_a?(Merchant)
    assert @mr.find_by_name('shopin1901').is_a?(Merchant)
  end

  def test_for_find_all_by_name_method
    assert_equal [], @mr.find_all_by_name('Mesan')
    assert_equal 2, @mr.find_all_by_name('PeRle').count
    assert_equal 2, @mr.find_all_by_name('perle').count
    assert @mr.find_all_by_name('perle')[0].is_a?(Merchant)
  end

  def test_inspect
    assert_equal '#<MerchantRepository 22 rows>', @mr.inspect
  end
end
