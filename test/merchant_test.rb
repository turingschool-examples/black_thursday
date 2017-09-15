require_relative 'test_helper'
require_relative '../lib/merchant'

class MerchantTest < Minitest::Test
attr_reader :merch, :merchant_info
  def set_up
    @merchant_info = {:id => "12337411", :name => "CJsDecor", :created_at => "2010-12-10", :updated_at => "2011-12-04"}
    @merch = Merchant.new(@merchant_info)
  end

  def test_it_exists
    set_up

    assert_instance_of Merchant, merch
  end

  def test_it_contains_merchants
    set_up

    assert_equal merchant_info, merch.merchant
  end

  def test_it_has_id
    set_up

    assert_equal 12337411, merch.id
  end

  def test_it_has_a_name
    set_up

    assert_equal "CJsDecor", merch.name
  end

  def test_it_has_a_created_at
    set_up

    assert_instance_of Time, merch.created_at
  end

  def test_it_has_a_updated_at
    set_up

    assert_instance_of Time, merch.updated_at
  end
end
