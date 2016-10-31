require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'

class MerchantTest < Minitest::Test
  attr_reader   :merchant

  def setup
    @merchant = Merchant.new({
      :id => 5,
      :name => "Turing School"
    })
  end

  def test_it_can_create_a_merchant
    assert merchant
  end

  def test_it_can_return_id
    assert_equal 5, merchant.id
  end

  def test_it_can_return_name
    assert_equal "Turing School", merchant.name
  end

end