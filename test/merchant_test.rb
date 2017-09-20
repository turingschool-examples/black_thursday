require_relative 'test_helper'
require_relative '../lib/merchant'
require_relative '../lib/sales_engine'

class MerchantTest < Minitest::Test
attr_reader :set_up
  def set_up
    merchant_info = {:id => "12337411", :name => "CJsDecor", :created_at => "2010-12-10", :updated_at => "2011-12-04"}
    merch = Merchant.new(merchant_info, [])
  end

  def test_it_exists
    assert_instance_of Merchant, set_up
  end

  def test_it_contains_merchants
    assert_equal merchant_info, set_up.merchant
  end

  def test_it_has_id
    assert_equal 12337411, set_up.id
  end

  def test_it_has_a_name
    assert_equal "CJsDecor", set_up.name
  end

  def test_it_has_a_created_at
    assert_instance_of Time, set_up.created_at
  end

  def test_it_has_an_updated_at
    assert_instance_of Time, set_up.updated_at
  end
end
