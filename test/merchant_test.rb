require_relative 'test_helper.rb'
require_relative '../lib/merchant.rb'

class MerchantTest < Minitest::Test
  def test_merchant_initializes
    merchant = Merchant.new({:id => 5, :name => 'Turing School'})

    assert_instance_of Merchant, merchant
  end

  def test_merchant_has_id_and_name
    merchant = Merchant.new({:id => 5, :name => 'Turing School'})

    assert_equal 5, merchant.id
    assert_equal 'Turing School', merchant.name
  end
end
