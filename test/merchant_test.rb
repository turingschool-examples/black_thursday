require "minitest/autorun"
require "minitest/emoji"
require "./lib/merchant"
require "./lib/merchant_repository"
require 'pry'
class MerchantTest < Minitest::Test

  def test_new_instance
    mr = MerchantRepository.new("./test/data/merchant_fixture.csv",self)

    assert_instance_of Merchant, mr.contents[12334105]
  end

  def test_can_access_name
    mr = MerchantRepository.new("./test/data/merchant_fixture.csv",self)

    assert_equal "MiniatureBikez", mr.contents[12334113].name
  end

  def test_can_access_created_at
    mr = MerchantRepository.new("./test/data/merchant_fixture.csv",self)

    assert_equal "2010-07-15 00:00:00 -0600", mr.contents[12334123].created_at.to_s
  end

  def test_can_acces_updated_at
    mr = MerchantRepository.new("./test/data/merchant_fixture.csv",self)

    assert_equal "2012-04-16 00:00:00 -0600", mr.contents[12334135].updated_at.to_s
  end

  def test_can_access_id
    mr = MerchantRepository.new("./test/data/merchant_fixture.csv",self)

    assert_equal 12334132, mr.contents[12334132].id
  end

end
