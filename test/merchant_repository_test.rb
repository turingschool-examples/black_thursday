require './test/test_helper'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  def test_it_exists
    mr = MerchantRepository.new("./test/merchants_sample.csv")
    assert_instance_of MerchantRepository, mr
  end

  def test_it_has_merchants
    skip
    mr = MerchantRepository.new("./test/merchants_sample.csv")
    assert_equal expected, mr.merchants
  end

  # def test_it_creates_merchant_array
  #   # make an array of merchants
  #
  #   # use test file
  #
  #   assert_equal
  # end

end
