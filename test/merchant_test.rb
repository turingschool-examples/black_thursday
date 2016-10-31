require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'

class MerchantTest < Minitest::Test

  def test_id_finds_id
    a = Merchant.new
    assert_equal 12334105, a.id
  end

end