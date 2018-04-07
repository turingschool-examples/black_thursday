require './lib/merchant_repository'
require 'minitest/autorun'
require 'minitest/pride'

class MerchantRepositoryTest< MiniTest::Test
  def test_it_exists
    merchant_repo = MerchantRepository.new('./data/merchants.csv')
    assert_instance_of MerchantRepository, merchant_repo
  end

  def test_it_can_load_all_data
    merchant_repo = MerchantRepository.new('./data/merchants.csv')
    assert_equal 475, merchant_repo.all.count
    assert merchant_repo.all.all? {|merchant|merchant.kind_of?(Merchant)}
    assert_equal 'Shopin1901', merchant_repo.all.first.name
    assert_equal 12334105, merchant_repo.all.first.id
  end

  def test_it_can_load_all_data
    merchant_repo = MerchantRepository.new('./data/merchants.csv')
    assert_equal 475, merchant_repo.all.count
    assert merchant_repo.all.all? {|merchant|merchant.kind_of?(Merchant)}
    assert_equal 'Shopin1901', merchant_repo.all.first.name
    assert_equal 12334105, merchant_repo.all.first.id
  end

  def test_it_can_find_by_id
    merchant_repo = MerchantRepository.new('./data/merchants.csv')

    result = merchant_repo.find_by_id(12334145)

    assert_instance_of Merchant, result
    assert_equal 'BowlsByChris', result.name
    assert_equal 12334145, result.id
  end

  def test_it_can_find_by_id_for_different_id
    merchant_repo = MerchantRepository.new('./data/merchants.csv')

    result = merchant_repo.find_by_id(12334159)

    assert_instance_of Merchant, result
    assert_equal 'SassyStrangeArt', result.name
    assert_equal 12334159, result.id
  end

end
