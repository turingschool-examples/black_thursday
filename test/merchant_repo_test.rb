require_relative "../test/test_helper"
require_relative "../lib/merchant"
require_relative "../lib/merchant_repo"

class MerchantRepoTest < Minitest::Test

  def test_it_exists
    mer_repo = MerchantRepo.new
    assert_instance_of MerchantRepo, mer_repo
  end

  def test_it_loads_file
    mer_repo = MerchantRepo.new
    assert_equal mer_repo.merchants, mer_repo.load_file("./data/merchants.csv")
  end
end
