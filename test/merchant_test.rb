require_relative 'test_helper'
require './lib/merchant'

class MerchantTest < Minitest::Test

  def test_it_opens_a_file
    merchant = Merchant.new({:id => 5, :name => "Turing School"})

    assert_instance_of Merchant, merchant
  end

  def test

  end
end
