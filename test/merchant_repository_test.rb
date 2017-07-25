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

end