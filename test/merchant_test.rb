require './lib/merchant'
require 'csv'
require 'minitest/autorun'
require 'minitest/emoji'

class MerchantTest < Minitest::Test

  def setup
    @merch = Merchant.new({:id => 5, :name => "Turing School"})
  end

  def test_it_exists
    assert_instance_of Merchant, @merch
  end

  def test_it_has_an_id
    assert_equal 5, @merch.id
  end

end
