require './test/test_helper'
require './lib/merchant_repo'

class MerchantRepoTest < Minitest::Test

  def test_merchant_repo_exists
    merchant_repo = MerchantRepo.new

    assert_instance_of MerchantRepo, merchant_repo
  end

end
