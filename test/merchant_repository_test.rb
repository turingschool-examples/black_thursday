require_relative 'test_helper'
require_relative '../lib/merchant_repository'
require_relative '../lib/fileio'

# merchant repository class
class MerchantRepositoryTest < Minitest::Test
  def setup
    @merchant_repository = MerchantRepository.new(FileIO.load('./test/fixtures/test_merchants.csv'))
  end

  def test_merchant_repository_exists
    assert_instance_of MerchantRepository, @merchant_repository
  end

  def test_creating_an_index_of_merchants_from_data
    assert_instance_of Hash, @merchant_repository.merchants
    assert_instance_of Merchant, @merchant_repository.merchants['12334105']
    assert_instance_of Merchant, @merchant_repository.merchants['12334112']
    assert_instance_of Merchant, @merchant_repository.merchants['12334113']
    assert_instance_of Merchant, @merchant_repository.merchants['12334115']
    assert_instance_of Merchant, @merchant_repository.merchants['12334123']
    assert_instance_of Merchant, @merchant_repository.merchants['12334132']
    assert_instance_of Merchant, @merchant_repository.merchants['12334135']
  end

  def test_all_returns_an_array_of_all_merchant_instances
    assert_instance_of Array, @merchant_repository.all
  end

  def test_all_returns_correct_names
    all_merchants = @merchant_repository.all
    actual_all_names = all_merchants.map do |merchant|
      merchant.name
    end
    expected = %w[Shopin1901 Candisart MiniatureBikez LolaMarleys Keckenbauer perlesemoi GoldenRayPress]
    assert_equal expected, actual_all_names
  end  

  def test_can_find_by_id
    actual_shopin = @merchant_repository.find_by_id('12334105')
    actual_candis = @merchant_repository.find_by_id('12334112')
    assert_instance_of Merchant, actual_shopin
    assert_instance_of Merchant, actual_candis
    assert_equal 'Shopin1901', actual_shopin.name
    assert_equal 'Candisart', actual_candis.name
  end

  def test_can_find_by_name
    actual_shopin = @merchant_repository.find_by_name('Shopin1901')
    actual_candis = @merchant_repository.find_by_name('Candisart')
    assert_instance_of Merchant, actual_shopin
    assert_instance_of Merchant, actual_candis
    assert_equal '12334105', actual_shopin.id
    assert_equal '12334112', actual_candis.id
  end

end
