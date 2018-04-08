require 'bigdecimal'
require 'csv'
require_relative 'test_helper'
require_relative '../lib/item_repository'
require_relative '../lib/fileio'

# Test for Item Repository class
class ItemRepositoryTest < Minitest::Test
  def setup
    file_path = FileIO.load('./test/fixtures/test_items.csv')
    @i_repo = ItemRepository.new(file_path)
  end

  def test_item_repository_exists
    assert_instance_of ItemRepository, @i_repo
  end

  def test_creating_an_index_of_items_from_data
    assert_instance_of Hash, @i_repo.items
    assert_instance_of Item, @i_repo.items['263567292']
    assert_instance_of Item, @i_repo.items['263567376']
    assert_instance_of Item, @i_repo.items['263567474']
  end

  def test_all_returns_an_array_of_all_merchant_instances
    skip
    assert_instance_of Array, @m_repo.all
  end

  def test_all_returns_correct_names
    skip
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
    skip
    actual_shopin = @m_repo.find_by_id('12334105')
    actual_candis = @m_repo.find_by_id('12334112')
    assert_instance_of Merchant, actual_shopin
    assert_instance_of Merchant, actual_candis
    assert_equal 'Shopin1901', actual_shopin.name
    assert_equal 'Candisart', actual_candis.name
  end

  def test_can_find_by_name
    skip
    actual_shopin = @m_repo.find_by_name('Shopin1901')
    actual_candis = @m_repo.find_by_name('Candisart')
    assert_instance_of Merchant, actual_shopin
    assert_instance_of Merchant, actual_candis
    assert_equal '12334105', actual_shopin.id
    assert_equal '12334112', actual_candis.id
  end

  def test_can_find_name_by_fragment
    skip
    actual = @m_repo.find_all_by_name('re')
    assert_equal %w[MiniatureBikez GoldenRayPress], actual
  end

  def test_it_can_generate_next_merchant_id
    skip
    expected = '12334136'
    actual = @m_repo.create_new_id
    assert_equal expected, actual
  end

  def test_can_create_new_merchant
    skip
    actual_jude = @m_repo.create('Jude')
    actual_cole = @m_repo.create('Cole')
    assert_instance_of Merchant, actual_jude
    assert_instance_of Merchant, actual_cole
    assert_equal 9, @m_repo.merchants.count
    assert_equal 'Jude', @m_repo.merchants['12334136'].name
    assert_equal 'Cole', @m_repo.merchants['12334137'].name
  end

  def test_merchant_can_be_updated
    skip
    @m_repo.update('12334135', 'ColeIsAwesomer')
    assert_equal 'ColeIsAwesomer', @m_repo.merchants['12334135'].name
  end

  def test_merchant_can_be_deleted
    skip
    @m_repo.delete('12334135')
    assert_equal 6, @m_repo.merchants.count
    assert_equal nil, @m_repo.merchants['12334135']
  end

end
