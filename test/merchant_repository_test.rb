require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/repository'
require_relative '../lib/sales_engine'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/merchant'
require_relative '../lib/item'

class MerchantRepositoryTest < Minitest::Test

  attr_reader :file_hash, :se, :path, :repo, :merch_repo

  def setup
    @file_hash = {

      items: './data/items.csv',
      merchants: './data/merchants.csv'
    }
    @path = 'test/fixtures/merchant_sample_small.csv'
    @se = SalesEngine.from_csv(file_hash)
    @repo = Repository.new(se, path, Merchant)
    @merch_repo = MerchantRepository.new(se, 'test/fixtures/merchant_sample_small.csv')
  end

  def test_finds_all_merchants

    assert_equal Array, merch_repo.all.class
    refute_empty merch_repo.all
  end

  def test_it_can_find_by_name

      assert_equal Merchant, merch_repo.find_by_name("Shopin1901").class
  end

  def test_it_returns_nil_for_wrong_name
      assert_nil merch_repo.find_by_name("bethknight")
  end

  def test_it_can_find_by_id
      assert_equal Merchant , merch_repo.find_by_id(12334112).class
  end

  def test_it_returns_nil_for_wrong_id
      assert_nil merch_repo.find_by_id("123456")
  end

  def test_find_all_by_name
      assert_equal 1 , merch_repo.find_all_by_name("shop").count
  end

  def test_returns_empty_array_if_no_match
    assert_equal [], merch_repo.find_all_by_name("Steph")
  end

end
