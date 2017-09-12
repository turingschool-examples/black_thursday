require "./test/test_helper"
require "./lib/merchant_repository"
require "./lib/merchant"
require "csv"


class MerchantRepositoryTest < Minitest::Test

  attr_reader :mr

  def setup
    @se = SalesEngine.from_csv({
  :items     => "./test/test_data/items.csv",
  :merchants => "./test/test_data/merchants.csv",
})
    @mr = MerchantRepository.new(se, merchant_csv)
    merchant_csv = "./test/test_data/merchants_short.csv"
  end


  def test_it_exists
    assert_instance_of MerchantRepository, mr
  end

end
