require "minitest/autorun"
require "./lib/merchant_repo"
require "csv"
require "pp"


class MerchantRepoTest < Minitest::Test

  def test_repo_exists
    repo = MerchantRepo.new
    assert repo
  end

  def test_if_merchants_array_created
    repo = MerchantRepo.new
    assert_equal Array, repo.merchants.class
  end

  def test_that_we_loaded_merchant_objects
    repo = MerchantRepo.new
    merchants = repo.merchants.class
    assert Merchant, merchants[0].class
  end

end
