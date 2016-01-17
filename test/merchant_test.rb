
require_relative './../lib/merchant'
require_relative 'spec_helper'
require          'pry'
require          'minitest/autorun'
require          'minitest/pride'


class MerchantTest < Minitest::Test

  def test_that_class_exist
    assert Merchant
  end

  def test_that_we_have_a_name_method
    assert Merchant.method_defined? :name
  end

  def test_that_we_have_a_id_method
    assert Merchant.method_defined? :id
  end

  def test_that_name_will_return_the_store_name_hash_value
    m = Merchant.new({:name => 'Shopin1901', :id => 12334105})

    assert_equal 'Shopin1901', m.name
  end

  def test_that_id_will_return_the_id_hash_value
    m = Merchant.new({:name => 'Shopin1901', :id => 12334105})

    assert_equal 12334105, m.id
  end

end
