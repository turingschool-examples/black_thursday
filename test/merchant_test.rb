require 'minitest'
require 'minitest/pride'
require_relative '../lib/merchant'

class MerchantTest < Minitest::Test
  def test_merchant_can_be_initialized
    merch = Merchant.new({:name => "test name", :merchant_id => 3, :created_at => "2012-03-27 14:53:59 UTC", :updated_at => "2012-03-27 14:53:59 UTC"})

    assert_equal Merchant, merch.class
  end

  def test_merchant_can_generate_an_id
    merch = Merchant.new({:name => "test name", :merchant_id => 3, :created_at => "2012-03-27 14:53:59 UTC", :updated_at => "2012-03-27 14:53:59 UTC"})

    assert_equal 3, merch.merchant_id
  end

  def test_merchant_can_pull_a_name
    merch = Merchant.new({:name => "test name", :merchant_id => 3, :created_at => "2012-03-27 14:53:59 UTC", :updated_at => "2012-03-27 14:53:59 UTC"})

    assert_equal "test name", merch.name
  end

  def test_merchant_can_pull_updated_at
    merch = Merchant.new({:name => "test name", :merchant_id => 3, :created_at => "2012-03-27 14:53:59 UTC", :updated_at => "2012-03-27 14:53:59 UTC"})

    assert_equal "2012-03-27 14:53:59 UTC", merch.updated_at
  end

  def test_merchant_can_pull_created_at
    merch = Merchant.new({:name => "test name", :merchant_id => 3, :created_at => "2012-03-27 14:53:59 UTC", :updated_at => "2012-03-27 14:53:59 UTC"})

    assert_equal "2012-03-27 14:53:59 UTC", merch.created_at
  end

end
