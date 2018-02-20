require './test/test_helper'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  def test_merchant_repository_class_exists
    merch_repo = MerchantRepository.new("./data/sample_data/merchants.csv")

    assert_instance_of MerchantRepository, merch_repo
  end
end
