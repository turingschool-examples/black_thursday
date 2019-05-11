require 'time'
require_relative 'test_helper'
require_relative '../lib/repositories/merchant_repository'
require_relative '../lib/file_io'

# merchant repository class
class MerchantRepositoryTest < Minitest::Test
  def setup
    csv = parse_data(merchants)
    @time = Time.now
    @m_repo = MerchantRepository.new(csv)
    @merchant12334105 = @m_repo.merchants[12334105]
    @merchant12334112 = @m_repo.merchants[12334112]
    @merchant12334113 = @m_repo.merchants[12334113]
    @merchant12334115 = @m_repo.merchants[12334115]
    @merchant12334123 = @m_repo.merchants[12334123]
    @merchant12334132 = @m_repo.merchants[12334132]
    @merchant12334135 = @m_repo.merchants[12334135]
  end

  def test_merchant_repository_exists
    assert_instance_of MerchantRepository, @m_repo
  end

  def test_creating_an_index_of_merchants_from_data
    expected = { 12334105 => @merchant12334105, 12334112 => @merchant12334112,
                 12334113 => @merchant12334113, 12334115 => @merchant12334115,
                 12334123 => @merchant12334123, 12334132 => @merchant12334132,
                 12334135 => @merchant12334135 }
    assert_equal expected, @m_repo.merchants
  end

  def test_all_returns_an_array_of_all_merchant_instances
    assert_equal [@merchant12334105, @merchant12334112,
                  @merchant12334113, @merchant12334115,
                  @merchant12334123, @merchant12334132,
                  @merchant12334135], @m_repo.all
  end

  def test_can_find_by_id
    assert_equal @merchant12334105, @m_repo.find_by_id(12334105)
    assert_equal @merchant12334112, @m_repo.find_by_id(12334112)
  end

  def test_can_find_by_name
    assert_equal @merchant12334105, @m_repo.find_by_name('Shopin1901')
    assert_equal @merchant12334112, @m_repo.find_by_name('Candisart')
  end

  def test_returns_nil_if_no_name_found
    actual = @m_repo.find_by_name('notaname')
    assert_nil actual
  end

  def test_can_find_name_by_fragment
    actual = @m_repo.find_all_by_name('re')
    assert_equal [@merchant12334113, @merchant12334135], actual
  end

  def test_it_can_generate_next_merchant_id
    assert_equal 12334136, @m_repo.create_new_id
  end

  def test_can_create_new_merchant
    actual_jude = @m_repo.create(name: 'Jude')
    assert_instance_of Merchant, actual_jude
    assert_equal 8, @m_repo.merchants.count
    assert_equal 'Jude', @m_repo.merchants[12334136].name
  end

  def test_can_create_a_different_merchant
    actual_cole = @m_repo.create(name: 'Cole')
    assert_instance_of Merchant, actual_cole
    assert_equal 8, @m_repo.merchants.count
    assert_equal 'Cole', @m_repo.merchants[12334136].name
  end

  def test_merchant_can_be_updated
    @m_repo.update(12334135, name: 'ColeIsAwesomer')
    assert_equal 'ColeIsAwesomer', @m_repo.merchants[12334135].name
  end

  def test_it_wont_update_id
    attributes = {
      id: 13000000
    }
    @m_repo.update(12334112, attributes)
    actual = @m_repo.merchants[13000000]
    assert_nil actual
  end

  def test_update_on_unknown_merchant_does_nothing
    actual = @m_repo.update(13000000, {})
    assert_nil actual
  end

  def test_merchant_can_be_deleted
    @m_repo.delete(12334135)
    assert_equal 6, @m_repo.merchants.count
    assert_nil @m_repo.merchants[12334135]
  end

  def test_magic_spec_harness_method_works
    expected = '#<MerchantRepository 7 rows>'
    assert_equal expected, @m_repo.inspect
  end

  def merchants
    %(id,name,created_at,updated_at
      12334105,Shopin1901,2010-12-10,2011-12-04
      12334112,Candisart,2009-05-30,2010-08-29
      12334113,MiniatureBikez,2010-03-30,2013-01-21
      12334115,LolaMarleys,2008-06-09,2015-04-16
      12334123,Keckenbauer,2010-07-15,2012-07-25
      12334132,perlesemoi,2009-03-21,2014-05-19
      12334135,GoldenRayPress,2011-12-13,2012-04-16)
  end

  def parse_data(data)
    CSV.parse(data, headers: :true, header_converters: :symbol)
  end
end
