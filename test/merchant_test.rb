require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant.rb'

class MerchantTest < MiniTest::Test

  def test_it_initializes_with_correct_id
    m = Merchant.new({:id => 5, :name => "Turing School"})
    assert_equal 5, m.id
  end

  def test_it_initializes_with_correct_name
    m = Merchant.new({:id => 5, :name => "Turing School"})
    assert_equal "Turing School", m.name
  end

end
