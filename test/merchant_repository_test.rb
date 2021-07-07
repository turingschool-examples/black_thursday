require './test/test_helper.rb'
require './lib/merchant_repository.rb'
require './lib/file_loader.rb'
require 'pry'

class MerchantRepositoryTest < Minitest::Test
  include FileLoader

  def setup
    @mr = MerchantRepository.new(load_file('./data/merchants.csv'))
    @id = 12337412
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @mr
  end

  def test_it_makes_array_of_merchants
    assert_instance_of Array, @mr.repository
    assert_instance_of Merchant, @mr.repository[0]
    assert_instance_of Merchant, @mr.repository[12]
    assert_equal 475, @mr.repository.count
  end

  def test_repository_can_return_all_merchants_in_array
    assert_instance_of Array, @mr.all
    assert_equal 475, @mr.all.count
    assert_instance_of Merchant, @mr.all[0]
    assert_instance_of Merchant, @mr.all[125]
  end

  def test_repo_can_find_by_id
    assert_equal @mr.all[0], @mr.find_by_id(12334105)
    assert_equal nil, @mr.find_by_id(10)
  end

  def test_repo_can_find_by_name
    assert_equal @mr.all[0], @mr.find_by_name('Shopin1901')
    assert_equal nil, @mr.find_by_name('BrianZanti')
  end

  def test_repo_can_find_all_by_name
    assert_equal [@mr.all[0]], @mr.find_all_by_name('19')
    assert_equal [], @mr.find_all_by_name('zzzzz')
  end

  def test_repo_can_create_new_merchants
    new_merchant = @mr.create(name: 'Bill')
    assert_instance_of Merchant, new_merchant
    assert_equal 'Bill', new_merchant.name
    assert @mr.repository.include?(new_merchant)
    assert_equal @id, new_merchant.id
  end

  def test_merchants_can_be_updated
    new_merchant = @mr.create(name: 'Bill')
    assert_equal @id, new_merchant.id
    assert_equal @mr.find_by_id(@id).name, 'Bill'
    @mr.update(@id, name: 'Billy')
    assert_equal @mr.find_by_id(@id).name, 'Billy'
    assert_equal nil, @mr.update(13000000, name: 'Billy')
  end

  def test_merchants_can_be_deleted
    new_merchant = @mr.create(name: 'Bill')
    assert_equal @id, new_merchant.id
    @mr.delete(@id)
    assert_equal nil, @mr.find_by_id(@id)
  end
end
