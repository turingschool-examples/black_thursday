require_relative 'test_helper.rb'
require_relative '../lib/merchant.rb'
require_relative '../lib/sales_engine.rb'
require_relative './master_hash.rb'

class MerchantTest < Minitest::Test
  def setup
    test_engine = TestEngine.new.god_hash
    sales_engine = SalesEngine.new(test_engine)
    @merchant = Merchant.new({:id => '5', :name => 'Turing School'}, sales_engine.merchants)
  end

  def test_merchant_initializes
    assert_instance_of Merchant, @merchant
  end

  def test_merchant_has_id_and_name
    assert_equal 5, @merchant.id
    assert_equal 'Turing School', @merchant.name
  end
end
