require 'minitest/autorun'
require 'minitest/pride'
require '../lib/merchant'

class MerchantTest < Minitest::Test
  def setup
    @m = Merchant.new({:id => 5, :name => "Turing School"})
  end

  def test_id_returns_id_of_merchant
    assert_equal 5, @m.id
  end

  def test_name_returns_name_of_merchant
    assert_equal "Turing School", @m.name
  end

end
