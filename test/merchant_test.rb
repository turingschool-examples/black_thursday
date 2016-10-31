gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require "minitest/nyan_cat"
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

  def test_it_checks_if_merchant_id_is_not_integer
    merchant_info = {:id => "yes", :name => "Turing School"}
    refute @merchant.merchant_info_clean?(merchant_info)
  end

  def test_it_checks_if_merchant_name_is_not_string
    merchant_info = {:id => 5, :name => :turing_school}
    refute @merchant.merchant_info_clean?(merchant_info)
  end

  def test_it_checks_if_merchant_info_is_empty
    merchant_info = {}
    refute @merchant.merchant_info_clean?(merchant_info)
  end

  def test_initialize_returns_argument_error_if_merchant_info_not_clean
    merchant_info = {:id => "y", :name => "Turing School"}
    assert_raises(ArgumentError) {Merchant.new(merchant_info)}
  end

  def test_error_message_explains_problem
    string = "Error: :id must be a number and :name must be a string."
    assert_equal string, @merchant.error
  end

end