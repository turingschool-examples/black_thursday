require_relative 'test_helper'
require_relative '../lib/merchant'

class MerchantTest < Minitest::Test
  def test_it_exists
    merch = Merchant.new({:id => "12337411", :name => "CJsDecor"})

    assert_instance_of Merchant, merch
  end

  def test_all_merchants
    merch = Merchant.new({:id => "12337411", :name => "CJsDecor"})

    assert_equal ({:id => "12337411", :name => "CJsDecor"}), merch.merchant
  end

  def test_it_can_find_by_id
    merch = Merchant.new({:id => "12337411", :name => "CJsDecor"})

    assert_equal 12337411, merch.id
  end

  def test_it_can_find_by_name
    merch = Merchant.new({:id => "12337411", :name => "CJsDecor"})

    assert_equal "CJsDecor", merch.name
  end
end
