require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'
require_relative '../test/file_hash_setup'
require_relative '../lib/merchant'


class MerchantTest < Minitest::Test

  attr_reader :file_hash, :path, :se, :repo, :merchant, :merchant_repository

  include FileHashSetup

  def setup
    super
    @merchant = Merchant.new( {
        :id => 12334105,
        :name => "Shopin1901"
      }, repo)
  end

  def test_it_finds_a_merchant_id
    assert_equal 12334105, merchant.id
  end

  def test_it_can_find_a_merchant_name
    assert_equal "Shopin1901", merchant.name
  end

  def test_it_can_find_items_by_id
    assert_equal 0, merchant.items
  end

end
