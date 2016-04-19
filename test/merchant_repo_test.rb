require "minitest/autorun"
require "./lib/merchant_repo"
require "csv"
require "pp"


class MerchantRepoTest < Minitest::Test

  def setup
    @repo = MerchantRepo.new
  end

  def test_repo_exists
    assert @repo
  end

  def test_if_merchants_array_created
    @repo.load_csv
    # puts @repo.all_merchants.inspect
    assert_equal Array, @repo.all_merchants.class
  end

  def test_that_we_loaded_merchant_objects
    @repo.load_csv
    assert Merchant, @repo.all_merchants[0].class
  end

  def test_it_finds_merchant_by_id
    @repo.load_csv
    assert_equal "Shopin1901", @repo.find_by_id("12334105").name
  end

end
