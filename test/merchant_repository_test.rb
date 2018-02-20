require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository.rb'


class MerchantRepositoryTest < Minitest::Test
  def test_it_exists
    merchant_repo = MerchantRepository.new('./test/fixtures/merchants.csv')

    assert_instance_of MerchantRepository, merchant_repo
  end

  def test_it_can_load_merchants
    merchant_repo = MerchantRepository.new('./test/fixtures/merchants.csv')

    assert_nil merchant_repo.load_merchants('./test/fixtures/merchants.csv')
  end

  def test_merchant_repo_has_merchants
    merchant_repo = MerchantRepository.new('./test/fixtures/merchants.csv')

    assert_equal 4, merchant_repo.all.count
    assert_instance_of Array, merchant_repo.all
    assert(merchant_repo.all) { |merchant| merchant.is_a?(Merchant) }
    assert_equal 'Shopin1901', merchant_repo.all.first.name
  end

  def test_it_can_find_merchant_by_id
    merchant_repo = MerchantRepository.new('./test/fixtures/merchants.csv')

    result = merchant_repo.find_by_id(1)

    assert_instance_of Merchant, result
    assert_equal 'Shopin1901', result.name
    assert_equal 1, result.id
  end

  def test_id_returns_nil_when_no_find_match
    merchant_repo = MerchantRepository.new('./test/fixtures/merchants.csv')

    result = merchant_repo.find_by_id(48_484)

    assert_nil result
  end

  def test_it_can_find_merchant_by_name
    merchant_repo = MerchantRepository.new('./test/fixtures/merchants.csv')

    result = merchant_repo.find_by_name('Shopin1901')

    assert_instance_of Merchant, result
    assert_equal 'Shopin1901', result.name
  end

  def test_name_returns_nil_when_no_find_match
    merchant_repo = MerchantRepository.new('./test/fixtures/merchants.csv')

    result = merchant_repo.find_by_name('lsFDDFslfj')

    assert_nil result
  end

  def test_it_can_find_all_by_name
    merchant_repo = MerchantRepository.new('./test/fixtures/merchants.csv')

    result = merchant_repo.find_all_by_name('Shopin1901')

    assert_instance_of Merchant, result[0]
    assert_equal 'Shopin1901', result[0].name

    result = merchant_repo.find_all_by_name('Sho')

    assert_equal 'Shopin1901', result[0].name

    result = merchant_repo.find_all_by_name('ksjadhf')
    assert_equal [], result
  end
end
