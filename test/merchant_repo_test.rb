require './test/test_helper'
require './lib/merchant_repo'

class MerchantRepositoryTest < Minitest::Test

  def setup
    csvfile = CSV.open "./data/merchants.csv", headers: true, header_converters: :symbol
    @merchant_repo = MerchantRepository.new(csvfile, "SalesEngine")
  end

  def test_it_exists_with_merchants_and_engine
    assert_instance_of MerchantRepository, @merchant_repo
    assert_equal "SalesEngine", @merchant_repo.engine
    assert_instance_of Hash, @merchant_repo.merchants
    assert_instance_of Merchant, @merchant_repo.merchants[12334105]
  end

  def test_it_can_inspect_itself
    assert_equal "#<MerchantRepository 475 rows>", @merchant_repo.inspect
  end

  def test_can_return_array_of_all_known_merchant_instances
    assert_instance_of Array, @merchant_repo.all
    assert_instance_of Merchant, @merchant_repo.all[0]
  end

  def test_can_find_by_merchant_id
    assert_nil @merchant_repo.find_by_id(123)
    assert_instance_of Merchant, @merchant_repo.find_by_id(12334105)
  end

  def test_it_can_find_by_name
    assert_nil @merchant_repo.find_by_name("Thisisafakenamenotinrepo")
    assert_instance_of Merchant, @merchant_repo.find_by_name("CJsDecor")
  end

  def test_it_can_find_all_by_name
    assert_equal [], @merchant_repo.find_all_by_name("zzzz")

    assert_instance_of Array, @merchant_repo.find_all_by_name("el")
    assert_instance_of Merchant, @merchant_repo.find_all_by_name("el")[0]
  end

end
