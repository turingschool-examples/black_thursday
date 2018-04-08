require_relative 'test_helper'
require_relative '../lib/merchant_repository'
require_relative '../lib/fileio'

# merchant repository class
class MerchantRepositoryTest < Minitest::Test
  def setup
    file_path = FileIO.load('./test/fixtures/test_merchants.csv')
    @m_repo = MerchantRepository.new(file_path)
  end

  def test_merchant_repository_exists
    assert_instance_of MerchantRepository, @m_repo
  end

  def test_creating_an_index_of_merchants_from_data
    assert_instance_of Hash, @m_repo.merchants
    assert_instance_of Merchant, @m_repo.merchants['12334105']
    assert_instance_of Merchant, @m_repo.merchants['12334112']
    assert_instance_of Merchant, @m_repo.merchants['12334113']
    assert_instance_of Merchant, @m_repo.merchants['12334115']
    assert_instance_of Merchant, @m_repo.merchants['12334123']
    assert_instance_of Merchant, @m_repo.merchants['12334132']
    assert_instance_of Merchant, @m_repo.merchants['12334135']
  end

  def test_all_returns_an_array_of_all_merchant_instances
    assert_instance_of Array, @m_repo.all
  end

  def test_all_returns_correct_names
    all_merchants = @m_repo.all
    actual_all_names = all_merchants.map(&:name)
    expected = %w[Shopin1901
                  Candisart
                  MiniatureBikez
                  LolaMarleys
                  Keckenbauer
                  perlesemoi
                  GoldenRayPress]
    assert_equal expected, actual_all_names
  end

  def test_can_find_by_id
    actual_shopin = @m_repo.find_by_id('12334105')
    actual_candis = @m_repo.find_by_id('12334112')
    assert_instance_of Merchant, actual_shopin
    assert_instance_of Merchant, actual_candis
    assert_equal 'Shopin1901', actual_shopin.name
    assert_equal 'Candisart', actual_candis.name
  end

  def test_can_find_by_name
    actual_shopin = @m_repo.find_by_name('Shopin1901')
    actual_candis = @m_repo.find_by_name('Candisart')
    assert_instance_of Merchant, actual_shopin
    assert_instance_of Merchant, actual_candis
    assert_equal '12334105', actual_shopin.id
    assert_equal '12334112', actual_candis.id
  end

  def test_can_find_name_by_fragment
    actual = @m_repo.find_all_by_name('re')
    assert_equal %w[MiniatureBikez GoldenRayPress], actual
  end

  def test_it_can_generate_next_merchant_id
    expected = '12334136'
    actual = @m_repo.create_new_id
    assert_equal expected, actual
  end

  def test_can_create_new_merchant
    actual_jude = @m_repo.create('JudeIsAwesome')
    actual_cole = @m_repo.create('ColeIsToo')
    assert_instance_of Merchant, actual_jude
    assert_instance_of Merchant, actual_cole
    assert_equal 9, @m_repo.merchants.count
    assert_equal "JudeIsAwesome", @m_repo.find_by_id(12334136).name
    assert_equal "ColeIsToo", @m_repo.find_by_id(12334137).name
  end
end
