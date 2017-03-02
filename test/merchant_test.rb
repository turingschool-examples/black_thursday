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
    @merchant = Merchant.new( { :id => 12334105,
                                :name => "Shopin1901",
                                :updated_at => "2011-12-04",
                                :created_at => "2010-12-10"}, repo)
  end

  def test_it_finds_a_merchant_id
    assert_equal 12334105, merchant.id
  end

  def test_it_can_find_a_merchant_name
    assert_equal "Shopin1901", merchant.name
  end

  def test_updated_at
    assert_equal Time , merchant.updated_at.class
  end

  def test_created_at
    assert_equal Time, merchant.created_at.class
  end

end
