require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/repository'
require_relative '../lib/merchant_repository'


class MerchantRepositoryTest < Minitest::Test


  def test_finds_all_
    merch_repo = MerchantRepository.new('test/fixtures/merchant_sample_small.csv')

    assert_equal Array, merch_repo.all.class
    refute_empty merch_repo.all
  end

  def test_it_can_find_by_name
      merch_repo = MerchantRepository.new('test/fixtures/merchant_sample_small.csv')

      assert_equal Merchant, merch_repo.find_by_name("Shopin1901").class
  end

  def test_it_returns_nil_for_wrong_name
      merch_repo = MerchantRepository.new('test/fixtures/merchant_sample_small.csv')

      assert_nil merch_repo.find_by_name("bethknight")
  end

  def test_it_can_find_by_id
      merch_repo = MerchantRepository.new('test/fixtures/merchant_sample_small.csv')
      assert_equal Merchant , merch_repo.find_by_id(12334112).class
  end

  def test_it_returns_nil_for_wrong_id
      merch_repo = MerchantRepository.new('test/fixtures/merchant_sample_small.csv')
      assert_nil merch_repo.find_by_id("123456")
  end

  def test_find_all_by_name
    merch_repo = MerchantRepository.new('test/fixtures/merchant_sample_small.csv')

    assert_equal 1 , merch_repo.find_all_by_name("shop").count
  end

  def test_returns_empty_array_if_no_match
    merch_repo = MerchantRepository.new('test/fixtures/merchant_sample_small.csv')
    assert_equal [], merch_repo.find_all_by_name("Steph")
  end

end
