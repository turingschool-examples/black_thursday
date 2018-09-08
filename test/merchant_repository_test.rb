require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository'
require './lib/merchant'
require 'pry'

class MerchantRepositoryTest < Minitest::Test
  def test_it_exists
    merchant_repository = MerchantRepository.new('./test/short_test/short_merchants.csv')

    assert_instance_of MerchantRepository, merchant_repository
  end

  def test_it_can_load_merchants
    merchant_repository = MerchantRepository.new('./test/short_test/short_merchants.csv')

    assert_instance_of Array, merchant_repository.all
  end

  def test_it_can_find_by_id
    merchant_repository = MerchantRepository.new('./test/short_test/short_merchants.csv')

    actual = merchant_repository.find_by_id(3)
    assert_instance_of Merchant, actual
    assert_equal "MiniatureBikez", actual.name
  end

  def test_find_id_can_return_nil
    merchant_repository = MerchantRepository.new('./test/short_test/short_merchants.csv')

    actual = merchant_repository.find_by_id(123)
    assert_nil actual
  end

  def test_it_can_find_by_name
    merchant_repository = MerchantRepository.new('./test/short_test/short_merchants.csv')

    actual = merchant_repository.find_by_name("MiniatureBikez")
    assert_instance_of Merchant, actual
    assert_equal 3, actual.id
  end

  def test_find_name_can_return_nil
    merchant_repository = MerchantRepository.new('./test/short_test/short_merchants.csv')

    actual = merchant_repository.find_by_name("Samuel")
    assert_nil actual
  end

  def test_it_can_find_all_by_name
    merchant_repository = MerchantRepository.new('./test/short_test/short_merchants.csv')

    merchant_2 = merchant_repository.find_by_name("MiniatureBikez")
    merchant_1 = merchant_repository.find_by_name("Shopin1901")

    assert_equal [], merchant_repository.find_all_by_name("Samuel")
    assert_equal [merchant_2], merchant_repository.find_all_by_name("MiniatureBikez")
    assert_equal [merchant_1, merchant_2], merchant_repository.find_all_by_name("In")
  end

  
end
