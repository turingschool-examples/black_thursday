require './test/test_helper'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  def test_it_created_instance_of_merchant_repo_class
    i = MerchantRepository.new
    assert_equal MerchantRepository, i.class
  end
end
