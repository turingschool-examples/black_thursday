require "minitest/autorun"
require "minitest/emoji"
require "./lib/merchant"
require "./lib/merchant_repository"
require 'pry'
class MerchantTest < Minitest::Test

  def test_new_instance
    mr = MerchantRepository.new("./test/data/merchants_test.csv",self)
    # mr.organize
    m = Merchant.new(mr.contents[0],mr)

    assert_instance_of Merchant, m
  end

  def test_can_access_name
    skip
    mr = MerchantRepository.new("./test/merchants_test.csv",self)
    mr.organize
    m = Merchant.new(mr.contents[0],mr)

    assert_equal "Shopin1901", m.name
  end

  def test_can_access_id
    skip
    mr = MerchantRepository.new("./test/merchants_test.csv",self)
    mr.organize
    m = Merchant.new(mr.contents[0],mr)

    assert_equal 12334105, m.id
  end
end
