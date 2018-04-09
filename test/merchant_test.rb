# frozen_string_literal: true

require './lib/file_loader.rb'
require './lib/merchant.rb'
require './lib/merchant_repository.rb'
require 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'
require 'mocha/mini_test'
require 'ostruct'
require 'pry'
require 'simplecov'
SimpleCov.start
require 'time'

# Provides an API of merchant repo for testing merchant class.
class MockMerchantRepository
  def find_merchant_by_merchant_id(_merchant_id)
    OpenStruct.new(name: 'Shopin1901', id: 12334185)
  end
end
# Tests Merchant class and functionality of methods.
class MerchantTest < Minitest::Test
  attr_reader :merchant,
              :parent

  def setup
    @merchant = Merchant.new(
      { id: '12334105',
        name: 'Shopin1901',
        created_at: '2010-12-10',
        updated_at: '2011-12-04' }, @parent
    )
  end

  def test_merchant_exists
    assert_instance_of Merchant, merchant
  end

  def test_it_initializes_with_merchant_spec_hash
    assert_instance_of Hash, merchant.merchant_specs
  end

  def test_it_initializes_with_parent
    @parent = mock('MerchantRepository')
    @parent.expects(:class).returns(MerchantRepository)
    assert_equal MerchantRepository, parent.class
  end

  def test_it_returns_by_searchable_name
    assert_equal 'shopin1901', merchant.searchable_name
  end

  def test_it_returns_merchants_id
    assert_equal 12334105, merchant.id
  end

  def test_it_returns_merchants_name
    assert_equal 'Shopin1901', merchant.name
  end

  def test_it_returns_merchants_creation_time
    assert_equal '2010-12-10', merchant.created_at
  end

  def test_it_returns_merchants_updated_time
    assert_equal '2011-12-04', merchant.updated_at
  end

# Once we have argument mocking figured out test with mock
  def test_it_finds_items_by_merchant_id
    skip
    item = mock('Item')

    assert_equal item, merchant.items
  end
end
