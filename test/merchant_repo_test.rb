require_relative 'test_helper'
require_relative '../lib/merchant_repo'

class MerchantRepoTest < Minitest::Test
  attr_reader :mr

  def setup
    @mr = MerchantRepo.new("./data/merchant_fixtures.csv")
  end

  def test_find_all_merchants
    assert_equal 100, mr.all.count
  end

  def test_it_returns_nil_when_no_id_present
    assert_nil mr.find_by_id(5)
  end

  def test_it_finds_instance_of_merchant_by_id
    assert_equal Merchant, mr.find_by_id(12334135).class
  end

  def test_it_finds_name_of_merchant
    


end
