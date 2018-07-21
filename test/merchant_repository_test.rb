require 'simplecov'
SimpleCov.start
require 'pry'
require 'minitest/pride'
require 'minitest/autorun'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_engine'


class MerchantRespositoryTest < Minitest::Test

  def setup
    @salesengine = SalesEngine.from_csv({merchants: './data/merchants.csv'})
    @merchant_repository = @salesengine.merchants
    # @merchant_1 = Merchant.new({id: 12334202, name: "VectorCoast"})
    # @merchant_2 = Merchant.new({id: 12336143, name: "ArtfulCoasters"})
    # @merchant_3 = Merchant.new({id: 12334601, name: "CoastalCreations16"})

  end

  def test_it_exists
    assert_instance_of MerchantRepository, @merchant_repository
  end

  def test_it_starts_with_no_merchants
    merchant_repository = MerchantRepository.new
    assert_equal [], merchant_repository.all
  end

  def test_we_can_find_a_merchant_by_id
    id = 12334105
    result = @merchant_repository.find_by_id(id).id
    assert_equal id, result
  end

  def test_we_can_find_merchant_by_name
    name = "Shopin1901"
    result = @merchant_repository.find_by_name(name).name
    assert_equal name, result
  end

  def test_we_can_find_all_merchants_by_name
    merchant_1 = @merchant_repository.find_by_id(12334202)
    merchant_2 = @merchant_repository.find_by_id(12334601)
    merchant_3 = @merchant_repository.find_by_id(12336143)
    expected = [merchant_1, merchant_2, merchant_3]
    result = @merchant_repository.find_all_by_name("Coast")
    assert_equal expected, result
  end

  def test_we_can_create_a_merchant_instance
    result = @merchant_repository.create_without_id({name: "Dylan"})
    assert_instance_of Merchant, result
  end

  def test_we_can_update_a_merchants_name_by_id
    expected = "Ben"
    @merchant_repository.update(12334202, "Ben")
    # binding.pry
    result = @merchant_repository.find_by_id(12334202).name
    assert_equal expected, result
  end

  def test_we_can_delete_a_merchant_instance
    expected = nil
    @merchant_repository.delete(12336143)
    result = @merchant_repository.find_by_id(12336143)
    assert_equal expected, result
  end

end
