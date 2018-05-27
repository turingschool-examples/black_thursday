require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine.rb'
require './lib/merchant_repository.rb'
require 'pry'

class MerchantRepositoryTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
    merchants = se.load_file(se.content[:merchants])
    @mr = MerchantRepository.new(merchants)
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
    new_merchant = @mr.create('Bill')
    assert_instance_of Merchant, new_merchant
    assert_equal 'Bill', new_merchant.name
    assert @mr.repository.include?(new_merchant)
    assert_equal 12337412, new_merchant.id
  end

  def test_merchants_can_be_updated
    new_merchant = @mr.create('Bill')
    assert_equal 12337412, new_merchant.id
    assert_equal @mr.find_by_id(12337412).name, 'Bill'
    @mr.update(12337412, 'Billy')
    assert_equal @mr.find_by_id(12337412).name, 'Billy'
  end

  def test_merchants_can_be_deleted
    new_merchant = @mr.create('Bill')
    assert_equal 12337412, new_merchant.id
    @mr.delete(12337412)
    assert_equal nil, @mr.find_by_id(12337412)
  end

end
