require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'

class MerchantTest < Minitest::Test

  def test_id_finds_id
    a = Merchant.new
    assert_equal 12334105, a.id
  end

  def test_it_can_have_multiple_ids
    a = Merchant.new
    assert_equal 11112222, a.id
  end
end