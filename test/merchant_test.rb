require 'minitest/autorun'
require 'minitest/nyan_cat'
require './lib/merchant.rb'


class MerchantTest < Minitest::Test
  attr_reader :merchant

  def setup
    @merchant = Merchant.new({:id => 5,
                              :name => "Turing School"})
  end

  def test_it_exists
    assert merchant
  end

  def test_it_has_id
    assert merchant.id
    assert_equal 5, merchant.id
  end

  def test_id_is_integer
    assert_equal Fixnum, merchant.id.class
  end

  def test_it_has_name
    assert merchant.name
    assert_equal "Turing School", merchant.name
  end
end
