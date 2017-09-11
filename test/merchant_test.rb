require "./test/test_helper"
require "./lib/merchant"


class MerchantTest < Minitest::Test

  attr_reader :m

  def setup
    @m = Merchant.new({:id => 5, :name => "Turing School"})
  end


  def test_it_exists
    assert_instance_of Merchant, m
  end

  def test_id_is_returned
    assert_equal 5, m.id
  end

  def test_id_is_integer
    @m = Merchant.new({:id => 5.0, :name => "Turing School"})
    assert_equal 5, m.id
  end

  def test_name_is_returned
    assert_equal "Turing School", m.name
  end


end
