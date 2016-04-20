require "minitest/autorun"
require "./lib/merchant_repo"
require "csv"

class MerchantRepoTest < Minitest::Test

  def setup
    @repo = MerchantRepo.new("./data/merchants.csv")
  end

  def test_repo_exists
    assert @repo
  end

  def test_if_merchants_array_created
    assert_equal Array, @repo.all_merchants.class
  end

  def test_that_we_loaded_merchant_objects
    assert Merchant, @repo.all_merchants[0].class
  end

  def test_it_finds_merchant_by_id
    assert_equal "Shopin1901", @repo.find_by_id(12334105).name
  end

  def test_it_finds_by_id_by_merchant_name
    assert_equal 12334105, @repo.find_by_name("Shopin1901").id
  end

  def test_it_finds_all_merchants_by_name_fragment
    assert @repo.find_all_by_name("design").any? do |merchant|
      merchant.name == "DizzyUnicornDesigns"
    end
  end

end
