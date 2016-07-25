require "./test/test_helper"
require "./lib/merchant_repo"

class MerchantsRepoTest < Minitest::Test

  def test_it_can_retun_the_full_merchant_count
    filepath = "./data/support/merchant_support.csv"
    merch_repo = MerchantsRepo.new(filepath)
    assert_equal 99, merch_repo.all.count
  end

  def test_it_can_find_a_merchant_via_id_number
    filepath = "./data/support/merchant_support.csv"
    merch_repo = MerchantsRepo.new(filepath)
    assert_equal "", merch_repo.find_by_id("12334473")
  end

  

end
