# frozen_string_literal: true

require './test/test_helper'
require './lib/merchant'
SimpleCov.start
require './lib/merchant_repository'
class MerchantRepositoryTest < Minitest::Test
  def setup
    @turing = Merchant.new(id: 1, name: 'Turing School')
    @candisart = Merchant.new(id: 2, name: 'Candisart')
    @miniaturebikez = Merchant.new(id: 3, name: 'MiniatureBikez')
    @bowlsbychris = Merchant.new(id: 4, name: 'bowlsbychris')
    @urcase17 = Merchant.new(id: 5, name: 'urcase17')
    @merchants = [@turing,
                  @candisart,
                  @miniaturebikez,
                  @bowlsbychris,
                  @urcase17]
  end

  def test_it_exists
    mr = MerchantRepository.new(@merchants)
    assert_instance_of MerchantRepository, mr
  end

  def test_it_returns_all_merchants
    mr = MerchantRepository.new(@merchants)
    assert_instance_of Array, mr.all
    mr.all.all? do |merchant|
      assert_instance_of Merchant, merchant
    end
    assert_equal @merchants, mr.all
  end

  def test_method_find_by_id
    mr = MerchantRepository.new(@merchants)
    assert_equal @turing, mr.find_by_id(1)
    assert_equal @candisart, mr.find_by_id(2)
    assert_equal @miniaturebikez, mr.find_by_id(3)
    assert_equal @bowlsbychris, mr.find_by_id(4)
    assert_equal @urcase17, mr.find_by_id(5)
  end

  def test_method_find_by_name
    mr = MerchantRepository.new(@merchants)
    assert_equal @turing, mr.find_by_name('Turing School')
    assert_equal @candisart, mr.find_by_name('Candisart')
    assert_equal @miniaturebikez, mr.find_by_name('MiniatureBikez')
    assert_equal @bowlsbychris, mr.find_by_name('bowlsbychris')
    assert_equal @urcase17, mr.find_by_name('urcase17')
    assert_nil mr.find_by_name('Zach')
  end

  def test_method_find_by_name_is_case_insensitive
    mr = MerchantRepository.new(@merchants)
    assert_equal @turing, mr.find_by_name('turing school')
    assert_equal @turing, mr.find_by_name('TuRinG ScHooL')
  end

  # returns a hash of all merchants which contain a name substring
  def test_method_find_all_by_name
    mr = MerchantRepository.new(@merchants)
    actual = mr.find_all_by_name('ca')
    assert_equal [@candisart, @urcase17], actual
    assert_equal [], mr.find_all_by_name('za')
    actual = mr.find_all_by_name('tur')
    assert_equal [@turing, @miniaturebikez], actual
  end

  def test_method_create
    mr = MerchantRepository.new(@merchants)
    assert_equal @merchants, mr.all
    mr.create('NewMerchant')
    # tests new merchant creation and tests that new merchants have iterated id
    assert_equal 'NewMerchant', mr.find_by_name('NewMerchant').name
  end

  def test_method_create_makes_new_id_by_incrementing_highest_id
    mr = MerchantRepository.new(@merchants)
    assert_equal @merchants, mr.all
    mr.create('NewMerchant')
    assert_equal 6, mr.find_by_name('NewMerchant').id
  end

  def test_method_update
    skip
    mr = MerchantRepository.new(@merchants)
    assert_equal 'Turing School', find_by_id(1)
    mr.update(id: 1, name: 'ZachsMerchant')
    assert_equal 'ZachsMerchant', find_by_id(1)
  end

  def test_method_delete
    skip
    mr = MerchantRepository.new(@merchants)
    assert_equal 'Turing School'.find_by_id(1)
    mr.delete(1)
    assert_nil find_by_id(1)
  end
end
