require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository'
require './lib/file_loader'


class MerchantRepositoryTest < Minitest::Test
  include FileLoader

  def setup
    @mr = MerchantRepository.new(load_file('./data/merchants.csv'))
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @mr
  end

  def test_it_can_return_all_merchants
    # skip
    assert_equal 475, @mr.all.count
    assert_instance_of Merchant, @mr.all[0]
    assert_instance_of Merchant, @mr.all[15]
  end

  def test_it_can_find_merchant_by_id
    # skip

    assert_instance_of Merchant, @mr.find_by_id(12334112)
  end

  def test_it_can_find_merchant_by_name
    # skip
    search_1 = @mr.find_by_name('JEJUM')
    assert_equal true, search_1.name.include?('jejum')
  end

  def test_it_can_find_a_different_merchant_by_name
    skip
    search = @mr.find_by_name('Shopin1901')
    assert_equal true, search.name.include?('shopin1901')
  end

  def test_it_can_find_all_merchants_with_matching_name_fragment
    # skip
    search_1 = @mr.find_all_by_name("M")
    assert_equal 164, search_1.count
    # 201 instances of the letter "M", but only 164 objects

    search_2 = @mr.find_all_by_name("mi")
    assert_equal 28, search_2.count

    search_3 = @mr.find_all_by_name("MINI")
    assert_equal 1, search_3.count
  end

  def test_it_can_create_a_new_id_number
    new_id = @mr.create_new_id_number

    assert_equal 12337412, new_id
  end

  def test_it_can_create_a_new_merchant
    skip
    name = "MockEtsyStore1"
    new_id = @mr.create_new_id_number
    new_merchant = @mr.create(new_id, name)
    assert_equal "MockEtsyStore1", new_merchant.name
    assert_equal 12337412, new_merchant.id
    assert_equal Time.now, new_merchant.created_at
    assert_equal Time.now, new_merchant.updated_at
  end

end
