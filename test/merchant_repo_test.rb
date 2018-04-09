require_relative 'test_helper'
require_relative '../lib/merchant_repo'

class MerchantRepoTest < Minitest::Test
  attr_reader :mr

  def setup
    @mr = MerchantRepo.new("./data/merchants.csv")
  end

  def test_it_exists
    assert_instance_of MerchantRepo, mr
  end

  def test_it_returns_all
    assert_equal 475, mr.all.count
    assert_instance_of Array, mr.all
    assert_instance_of Merchant, mr.all.sample
  end

  def test_it_returns_nil_if_there_is_no_id
    assert_nil mr.find_by_id(5)
  end

  def test_it_finds_merchant_by_id
    expected = "TheCullenChronicles"
    assert_equal expected, mr.find_by_id("12336927").name
  end

  def test_it_returns_nil_without_name
    assert_equal Merchant, mr.find_by_name("Shopin1901")
  end
  
end
