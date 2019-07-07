require './test/test_helper'
require './lib/merchant_repository'
require './lib/file_loader'


class MerchantRepositoryTest < Minitest::Test
  include FileLoader

  def setup
    @mock_data = [
        {id: 12334105,
        name: 'Shopin1901',
        created_at: Time.now,
        updated_at: Time.now},
        {id: 12334112,
        name: 'Candisart',
        created_at: Time.now,
        updated_at: Time.now},
        {id: 12334113,
        name: 'MiniatureBikez',
        created_at: Time.now,
        updated_at: Time.now},
        {id: 12334115,
        name: 'LolaMarleys',
        created_at: Time.now,
        updated_at: Time.now},
        {id: 12334123,
        name: 'Keckenbauer',
        created_at: Time.now,
        updated_at: Time.now},
        {id: 12334207,
        name: 'BloominScents',
        created_at: Time.now,
        updated_at: Time.now}
        ]

    @mr = MerchantRepository.new(@mock_data)
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @mr
  end

  def test_it_can_return_all_merchants
    assert_equal 6, @mr.all.count
    assert_equal 'Shopin1901', @mr.all[0].name
    assert_equal 'Keckenbauer', @mr.all[4].name
  end

  def test_it_can_find_merchant_by_id
    assert_equal @mr.all[2], @mr.find_by_id(12334113)
  end

  def test_it_can_find_merchant_by_name
    search_1 = @mr.find_by_name('LolaMarleys')
    assert_equal @mr.all[3], search_1

    search_2 = @mr.find_by_name('MiniatureBikez')
    assert_equal @mr.all[2], search_2
  end

  def test_it_can_find_all_merchants_with_matching_name_fragment
    search_1 = @mr.find_all_by_name('M')
    assert_equal 3, search_1.count

    search_2 = @mr.find_all_by_name('mi')
    assert_equal 2, search_2.count

    search_3 = @mr.find_all_by_name('MINI')
    assert_equal 1, search_3.count
  end

  def test_it_can_create_a_new_id_number
    new_id = @mr.create_new_id_number

    assert_equal 12334208, new_id
  end

  def test_it_can_create_a_new_merchant
    @mr.create({
      :name => 'MockEtsyStore1',
      :created_at => Time.now,
      :updated_at => Time.now
      })

    assert_equal 'MockEtsyStore1', @mr.all[-1].name
    assert_equal 12334208, @mr.all[-1].id
    assert_equal 7, @mr.all.count
  end

  def test_it_can_update_a_merchant_name
    assert_equal 'Candisart', @mr.all[1].name

    @mr.update(12334112, :name => 'CandisART')
    assert_equal 'CandisART', @mr.all[1].name

    updated_merchant = @mr.update(1234, :name => 'uh oh my id is not present')
    assert_nil updated_merchant
  end

  def test_it_can_delete_a_merchant_record
    @mr.create({
      :name => 'SampleMerchant',
      :created_at => Time.now,
      :updated_at => Time.now})

    assert_equal 'SampleMerchant', @mr.all[-1].name
    assert_equal 12334208, @mr.all[-1].id
    assert_equal 7, @mr.all.count

    @mr.delete(12334208)
    assert_equal 6, @mr.all.count
  end
end
