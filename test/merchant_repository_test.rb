require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository'
require './lib/file_loader'


class MerchantRepositoryTest < Minitest::Test
  include FileLoader

  def setup
    @mr = MerchantRepository.new(load_file('./data/merchants_test_data.csv'))
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @mr
  end

  def test_it_can_return_all_merchants
    # skip
    assert_equal 5, @mr.all.count
    assert_kind_of Merchant, @mr.all[0]
  end

  def test_it_can_find_merchant_by_id
    # skip
    assert_kind_of Merchant, @mr.find_by_id(12334105)
  end

  def test_it_can_find_merchant_by_name
    # skip
    assert_instance_of Merchant, @mr.find_by_name("CadeauJudaica")
  end

  def test_it_can_find_all_merchants_with_matching_name_fragment
    

  end

end
