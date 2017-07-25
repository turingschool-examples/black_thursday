require './test/test_helper'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  def test_it_exists
    mr = MerchantRepository.new('./data/merchants.csv', self)

    assert_instance_of MerchantRepository, mr
  end

  def test_it_initializes_with_an_empty_array
    mr = MerchantRepository.new('./data/merchants.csv', self)

    assert_equal 475,  mr.merchants.count
  end

  def test_it_can_return_all_merchants
    mr = MerchantRepository.new('./data/merchants.csv', self)

    target = mr.all

    assert_equal Array, target.class
    assert_equal 475, target.count
  end

  def test_it_can_find_by_id
    mr = MerchantRepository.new('./data/merchants.csv', self)

    target = mr.find_by_id("12334135")
    target_2 = mr.find_by_id("00000000")

    assert_equal "GoldenRayPress", target.name
    assert_nil target_2
  end

  def test_it_can_find_by_name
      mr = MerchantRepository.new('./data/merchants.csv', self)

      target = mr.find_by_name("GoldenRayPress")
      target_2  = mr.find_by_name("goldenraypress")
      target_3 = mr.find_by_name("Not a name")

      assert_equal "GoldenRayPress", target.name
      assert_equal "GoldenRayPress", target_2.name
      assert_nil target_3
  end
end