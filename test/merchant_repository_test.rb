require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/repository'
require_relative '../lib/merchant_repository'


class MerchantRepositoryTest < Minitest::Test

  def test_it_can_find_merchant_by_name
      merch_repo = MerchantRepository.new('test/fixtures/merchant_sample_small.csv')

      assert_equal "Shopin1901", merch_repo.find_by_name("Shopin1901")
  end


  #
  # def test_parse_headers
  #   skip
  #   mr = MerchantRepository.new
  #
  #   mr.parse_headers('test/fixtures/merchant_sample_small.csv')
  #
  #   assert_equal "12334105", result
  # end
  #

  #
  # def test_it_can_return_nil
  #     mr = MerchantRepository.new
  #     mr.parse_headers('test/fixtures/merchant_sample_small.csv')
  #
  #     assert_nil mr.find_by_name("bethknight")
  # end
  #
  # def test_it_can_find_all_merchants_by_name
  #
  #   mr = MerchantRepository.new
  #   mr.parse_headers('test/fixtures/merchant_sample_small.csv')
  #
  #   assert_equal ["SHOPIN1901"], mr.find_all_by_name("SHOP")
  # end
  #
  # def test_it_returns_empty_array_if_no_names_match
  #   skip
  #   mr = MerchantRepository.new
  #   mr.parse_headers('test/fixtures/merchant_sample_small.csv')
  #
  #   assert_equal [], mr.find_all_by_name("Beth")
  # end

end
