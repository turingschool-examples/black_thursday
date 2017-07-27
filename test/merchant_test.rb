require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/merchant'

class MerchantTest < Minitest::Test

  def test_it_takes_hash
    m = Merchant.new({:id => 5, :name => "Turing School"})

    assert_equal 5, m.id
    assert_equal "Turing School", m.name
  end
end
