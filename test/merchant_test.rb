require_relative "test_helper.rb"
require_relative "../lib/merchant"
require_relative "../lib/merchant_repository"
class MerchantTest < Minitest::Test

  def test_new_instance
    mr = MerchantRepository.new("./test/merchants_test.csv",self)
    mr.organize
    m = Merchant.new(mr.contents[0],mr)

    assert_instance_of Merchant, m
  end

  def test_can_access_name
    mr = MerchantRepository.new("./test/merchants_test.csv",self)
    mr.organize
    m = Merchant.new(mr.contents[0],mr)

    assert_equal "Shopin1901", m.name
  end

  def test_can_access_id
    mr = MerchantRepository.new("./test/merchants_test.csv",self)
    mr.organize
    m = Merchant.new(mr.contents[0],mr)

    assert_equal 12334105, m.id
  end
end
