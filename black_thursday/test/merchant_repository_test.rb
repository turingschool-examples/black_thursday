require_relative 'test_helper'
require 'csv'
require './lib/merchant'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  attr_reader :merchants,
              :repository

  def setup
    @repository = MerchantRepository.new("./data/merchants.csv")
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @repository
  end

  def test_it_can_return_all_merchants
    assert_equal repository.merchants, @repository.all
  end

  def test_it_can_find_merchant_by_id
    assert_equal Merchant, repository.find_by_id(12334113).class
    assert_equal "MiniatureBikez", repository.find_by_id(12334113).name
    assert_equal "2010-03-30", repository.find_by_id(12334113).created_at
  end

  def test_find_by_id_edge_case
    assert_nil repository.find_by_id(67869584684)
    assert_nil repository.find_by_id("smoosh")
    assert_nil repository.find_by_id("12334113")
  end

  def test_it_can_find_by_name_returns_first_merchant_with_matching_name
    assert_equal Merchant, repository.find_by_name("MiniatureBikez").class
    assert_equal "MiniatureBikez", repository.find_by_name("MiniatureBikez").name
    assert_equal 12334113, repository.find_by_name("MiniatureBikez").id
  end
end
