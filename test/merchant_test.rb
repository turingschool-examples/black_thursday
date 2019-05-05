# frozen_string_literal: true

require 'simplecov'
SimpleCov.start
require './lib/file_loader.rb'
require './lib/merchant.rb'
require './lib/merchant_repository.rb'
require 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'
require 'ostruct'
require 'pry'
require 'time'

# Provides an API of merchant repo for testing merchant class.
class MockMerchantRepository
  def find_items_by_merchant_id(_merchant_id)
    OpenStruct.new(name: 'Shopin1901', id: 12334185)
  end

  def find_invoices_by_merchant_id(_id)
    OpenStruct.new(id: 1, merchant_id: 12335938)
  end
end
# Tests Merchant class and functionality of methods.
class MerchantTest < Minitest::Test
  MERCHANT_BODY = {
    id: '12335938',
    name: 'Shopin1901',
    created_at: '2010-12-10',
    updated_at: '2011-12-04'
  }.freeze

  attr_reader :merchant

  def setup
    @merchant = Merchant.new(MERCHANT_BODY, MockMerchantRepository.new)
  end

  def test_merchant_exists
    assert_instance_of Merchant, merchant
  end

  def test_it_initializes_with_merchant_spec_hash
    assert_instance_of Hash, merchant.merchant_specs
  end

  def test_it_initializes_with_parent
    assert_equal MockMerchantRepository, merchant.parent.class
  end

  def test_it_returns_by_searchable_name
    assert_equal 'shopin1901', merchant.searchable_name
  end

  def test_it_returns_merchants_id
    assert_equal 12335938, merchant.id
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

  def test_it_finds_items_by_merchant_id
    assert_equal 'Shopin1901', merchant.items.name
    assert_equal 12334185, merchant.items.id
  end

  def test_it_finds_invoices_by_merchant_id
    assert_equal 1, merchant.invoices.id
    assert_equal 12335938, merchant.invoices.merchant_id
  end
end
