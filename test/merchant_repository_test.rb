require './lib/merchant_repository'
require 'minitest/autorun'
require 'minitest/pride'

class MerchantRepositoryTest< MiniTest::Test
  def test_it_exists
    merchant_repo = MerchantRepository.new("./data/merchants.csv")
    assert_instance_of MerchantRepository, merchant_repo
  end

  def test_it_can_load_all_data
    merchant_repo = MerchantRepository.new("./data/merchants.csv")
    assert_equal 475, merchant_repo.all.count
    assert_equal "Shopin1901", merchant_repo.all.first.name
  end

end
