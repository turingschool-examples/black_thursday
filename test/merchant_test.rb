require_relative 'test_helper'
require './lib/merchant'

class MerchantTest < Minitest::Test

  def setup
    merchant_info = {:id => 5, :name => "Turing School"}
    @merchant = Merchant.new(merchant_info)
  end

  def test_it_exists
    assert @merchant
  end

  def test_it_initializes_merchant_id
    assert_equal 5, @merchant.id
  end

  def test_it_initializes_merchant_name
    assert_equal "Turing School", @merchant.name
  end

  def test_it_creates_empty_name_if_merchant_info_empty
    merchant = Merchant.new(nil)    
    assert_equal nil, merchant.name
  end

  def test_it_creates_empty_name_if_merchant_info_has_no_name
    merchant = Merchant.new({:id => 5, :place => "Turing School"})    
    assert_equal nil, merchant.name
  end

  def test_it_creates_empty_id_if_merchant_info_empty
    merchant = Merchant.new(nil)    
    assert_equal nil, merchant.id
  end

  def test_it_creates_empty_name_if_merchant_info_has_no_id
    merchant = Merchant.new({:number => 5, :name => "Turing School"})    
    assert_equal nil, merchant.id
  end

end
