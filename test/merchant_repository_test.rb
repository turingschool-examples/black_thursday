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
    @merchants_obj = [@turing,
                     @candisart,
                     @miniaturebikez,
                     @bowlsbychris,
                     @urcase17]

    @merchants = [['id:1', 'name:Turing School'],
                  ['id:2', 'name:Candisart'],
                  ['id:3', 'name:MiniatureBikez'],
                  ['id:4', 'name:bowlsbychris'],
                  ['id:5', 'name:urcase17']]
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

    expected_names = @merchants_obj.map do |merchant|
      merchant.name
    end
    actual_names = mr.all.map do |merchant|
      merchant.name
    end
    # these enums are neccesary because merchant repo creates new merchants objects from 
    # passed in values. Therefore object ids cannot be checked, only values
    assert_equal expected_names, actual_names

  end

  def test_method_find_by_id
    mr = MerchantRepository.new(@merchants)
    expected = @turing.attributes
    actual = mr.find_by_id(1).attributes
    assert_equal expected, actual
    expected = @miniaturebikez.attributes
    actual = mr.find_by_id(3).attributes
    assert_equal expected, actual
    expected = @urcase17.attributes
    actual = mr.find_by_id(5).attributes
    assert_equal expected, actual
  end

  def test_method_find_by_name
    mr = MerchantRepository.new(@merchants)
    mr = MerchantRepository.new(@merchants)
    expected = @turing.name
    actual = mr.find_by_name(expected).name
    assert_equal expected, actual
    expected = @miniaturebikez.name
    actual = mr.find_by_name(expected).name
    assert_equal expected, actual
    expected = @urcase17.name
    actual = mr.find_by_name(expected).name
    assert_equal expected, actual
    expected = 'Missing Merchant'
    actual = mr.find_by_name(expected)
    assert_nil actual
  end

  def test_method_find_by_name_is_case_insensitive
    mr = MerchantRepository.new(@merchants)
    assert_equal @turing.attributes, mr.find_by_name('turing school').attributes
    assert_equal @turing.attributes, mr.find_by_name('TuRinG ScHooL').attributes
  end

  # returns a hash of all merchants which contain a name substring
  def test_method_find_all_by_name
    mr = MerchantRepository.new(@merchants)
    actual = mr.find_all_by_name('ca')
    assert(actual.all? { |merchant| merchant.class == Merchant })
    expected = [@candisart, @urcase17].map do |merchant|
      merchant.attributes
    end 
    actual = actual.map do |merchant|
      merchant.attributes
    end 
    assert_equal expected, actual
    assert_equal [], mr.find_all_by_name('za')
  end

  def test_helper_find_highest_id
    mr = MerchantRepository.new(@merchants)
    assert_equal 5, mr.find_highest_id
  end

  def test_method_create
    mr = MerchantRepository.new(@merchants)
    mr.create(name: 'NewMerchant')
    # tests new merchant creation and tests that new merchants have iterated id
    assert_equal 'NewMerchant', mr.find_by_name('NewMerchant').name
  end

  def test_method_create_makes_new_id_by_incrementing_highest_id
    mr = MerchantRepository.new(@merchants)
    mr.create(name: 'NewMerchant')
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
