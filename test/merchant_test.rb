require './test/test_helper'
require './lib/merchant'

class MerchantTest < Minitest::Test
  def setup
    @merchant = Merchant.new({:id => 5, :name => "Turing School"})
  end

  def test_merchant_class_exists
    assert_instance_of Merchant, @merchant
  end

  def test_id_and_name
    assert_equal 5, @merchant.id
    assert_equal "Turing School", @merchant.name
  end

  def test_other_attributes
    merchant = Merchant.new({:id => 1, :name => "Haliburton"})

    assert_equal 1, merchant.id
    assert_equal "Haliburton", merchant.name
  end
end
