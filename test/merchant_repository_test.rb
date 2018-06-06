# frozen_string_literal: false

require_relative 'test_helper'
require './lib/sales_engine'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv(merchants: './data/merchants.csv')
    @mr = @se.merchants
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @mr
  end

  def test_merchant_repo_holds_all_instances_of_merchants
    assert_equal 475, @mr.all.length
  end

  def test_all_returns_array_of_all_merchant_objects
    merchants = @mr.all
    assert merchants.all? do |merchant|
      merchant.class == Merchant
    end
  end

  def test_find_by_id_returns_merchants_with_given_id
    refute @mr.find_by_id('notarealid')
    assert_instance_of Merchant, @mr.find_by_id(12_334_105)
    assert_equal 12_334_105, @mr.find_by_id(12_334_105).id
    assert_equal 'Shopin1901', @mr.find_by_id(12_334_105).name
  end

  def test_find_by_name_returns_merchant_object_with_given_name
    refute @mr.find_by_name('notarealname')
    assert_instance_of Merchant, @mr.find_by_name('Candisart')
    assert_equal 12_334_112, @mr.find_by_name('Candisart').id
    assert_equal 'Candisart', @mr.find_by_name('Candisart').name
  end

  def test_find_all_by_name_fragment
    assert_instance_of Array, @mr.find_all_by_name('art')
    assert_equal 35, @mr.find_all_by_name('art').length
    assert_equal 3, @mr.find_all_by_name('style').length
    assert_equal [], @mr.find_all_by_name('asdgihweogdv')
  end

  def test_it_can_create_a_new_merchant_object
    refute @mr.find_by_id(12_337_412)
    attributes = { name: 'Turing School of Software and Design' }
    @mr.create(attributes)
    expected = 'Turing School of Software and Design'
    assert_equal expected, @mr.find_by_id(12_337_412).name
  end

  def test_it_can_update_a_merchants_name
    @mr.create(name: 'test')
    assert @mr.find_by_name('test')
    refute @mr.find_by_name('new_name')

    @mr.update(12_337_412, name: 'new_name')
    refute @mr.find_by_name('test')
    assert @mr.find_by_name('new_name')
  end

  def test_it_can_delete_a_merchant_object
    assert @mr.find_by_id(12_337_411)
    @mr.delete(12_337_411)
    refute @mr.find_by_id(12_337_411)
  end
end
