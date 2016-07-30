require './test/test_helper'
require './lib/merchant'

class MerchantTest < Minitest::Test
  def merchant_test_setup
    [ Merchant.new({ :id => 12334115, :name => "LolaMarleys" }),
      Merchant.new({ :id => 12334132, :name => "perlesemoi" }),
      Merchant.new({ :id => 12334141, :name => "jejum" }) ]
  end

  def test_it_creates_a_merchant
    merchants = merchant_test_setup

    assert_instance_of Merchant, merchants[0]
    assert_instance_of Merchant, merchants[1]
    assert_instance_of Merchant, merchants[2]
  end

  def test_it_finds_a_merchant_id
    merchants = merchant_test_setup

    assert_equal 12334115, merchants[0].id
    assert_equal 12334132, merchants[1].id
    assert_equal 12334141, merchants[2].id
  end

  def test_it_finds_a_merchant_name
    merchants = merchant_test_setup

    assert_equal "LolaMarleys", merchants[0].name
    assert_equal "perlesemoi",  merchants[1].name
    assert_equal "jejum",       merchants[2].name
  end
end
