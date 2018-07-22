require './test/test_helper'
require './lib/file_loader'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  include FileLoader

  def setup
    @mr = MerchantRepository.new(load_file('./data/merchants.csv'))
    @id = 12337412
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @mr
  end

  def test_all
    assert_instance_of Array, @mr.merchant_repo
    assert_instance_of Merchant, @mr.merchant_repo[0]
    assert_equal 475, @mr.merchant_repo.count
  end

  def test_find_by_id
    assert_equal nil, @mr.find_by_id(1233410)
    assert_equal @mr.all[0], @mr.find_by_id(12334105)
  end

  def test_find_by_name
    assert_equal nil, @mr.find_by_name("Shopin190")
    assert_equal @mr.all[0], @mr.find_by_name("shopin1901")
  end

  def test_find_all_by_name_fragment
    assert_equal [], @mr.find_all_by_name("fjdkaljf")
    assert_equal [@mr.all[0]], @mr.find_all_by_name("shopin")
  end

  def test_repo_can_create_new_merchants
    new_merchant = @mr.create(name: 'Jennifer')
    assert_instance_of Merchant, new_merchant
    assert_equal 'Jennifer', new_merchant.name
    assert @mr.merchant_repo.include?(new_merchant)
    assert_equal @id, new_merchant.id
  end

  def test_merchants_can_be_updated
    new_merchant = @mr.create(name: 'Jennifer')
    assert_equal @id, new_merchant.id
    assert_equal @mr.find_by_id(@id).name, 'Jennifer'
    @mr.update(@id, name: 'Jenn')
    assert_equal @mr.find_by_id(@id).name, 'Jenn'
    assert_equal nil, @mr.update(12337499, name: 'Joseph')
  end

end
