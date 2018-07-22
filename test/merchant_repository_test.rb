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
    assert_equal @mr.all[7], search_1
    assert_equal true, search_1.name.include?('jejum')

    search_2 = @mr.find_by_name('MiniatureBikez')
    assert_equal @mr.all[2], search_2
    # assert_equal true, search_2.name.include?('miniaturebikez')
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
    # skip
    new_merchant = @mr.create({:name => 'MockEtsyStore1'})

    assert_equal 'MockEtsyStore1', new_merchant.name
    assert_equal 12337412, new_merchant.id
    assert_equal new_merchant, @mr.all.last
    assert_equal 476, @mr.all.count
  end

  def test_it_can_update_a_merchant_name
    updated_merchant_1 = @mr.update(12337409, :name => 'CardsByMary&Kate')

    assert_equal 'CardsByMary&Kate', updated_merchant_1.name

    updated_merchant_2 = @mr.update(1234, :name => 'uh oh my id is not present')

    assert_nil updated_merchant_2
  end

end
