require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/repository'
require_relative '../lib/merchant_repository'


class MerchantRepositoryTest < Minitest::Test


  def test_finds_all_merchants
    merch_repo = MerchantRepository.new('test/fixtures/merchant_sample_small.csv')

    assert_equal ["boop"], merch_repo.all
  end

  def test_it_can_find_merchant_by_name
      merch_repo = MerchantRepository.new('test/fixtures/merchant_sample_small.csv')

      assert_equal "Shopin1901", merch_repo.find_by_name("Shopin1901")
  end

  def test_it_returns_nil_for_wrong_name
      merch_repo = MerchantRepository.new('test/fixtures/merchant_sample_small.csv')

      refute merch_repo.find_by_name("bethknight")
  end

  def test_it_can_find_merchant_by_id
      merch_repo = MerchantRepository.new('test/fixtures/merchant_sample_small.csv')

      assert_equal "12334105", merch_repo.find_by_id("12334105")
  end

  def test_it_returns_nil_for_wrong_id

      merch_repo = MerchantRepository.new('test/fixtures/merchant_sample_small.csv')

      refute merch_repo.find_by_id("123456")
  end

end
