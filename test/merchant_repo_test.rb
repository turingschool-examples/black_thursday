require_relative "../test/test_helper"
require_relative "../lib/merchant"
require_relative "../lib/merchant_repo"
require "pry"

class MerchantRepoTest < Minitest::Test

  def test_it_exists
    mer_repo = MerchantRepo.new
    assert_instance_of MerchantRepo, mer_repo
  end

  def test_it_loads_file
    mer_repo = MerchantRepo.new
    assert_equal mer_repo.merchants, mer_repo.load_file("./data/merchants.csv")
  end

  def test_it_finds_by_id
    mer_repo = MerchantRepo.new
    mer_repo.load_file("./data/merchants.csv")
    assert_instance_of Merchant, mer_repo.find_by_id(12334112)
  end
end
