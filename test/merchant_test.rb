require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant.rb'

class MerchantTest < Minitest::Test

  def setup
    @merchant_data = ["12334132","perlesemoi","2009-03-21","2014-05-19"]
  end

  def test_id
    merchant = Merchant.new(@merchant_data)
    assert_equal 12334132, merchant.id
  end

  def test_it_can_find_name
    merchant = Merchant.new(@merchant_data)
    assert_equal "perlesemoi", merchant.name
  end

  def test_it_can_find_creation_date
    merchant = Merchant.new(@merchant_data)
    assert_equal "2009-03-21", merchant.created_at
  end

  def test_it_can_find_date_updated
    merchant = Merchant.new(@merchant_data)
    assert_equal "2014-05-19", merchant.updated_at
  end

end
