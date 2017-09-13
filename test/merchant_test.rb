require "./test/test_helper"
require "./lib/merchant"


class MerchantTest < Minitest::Test

  def test_it_exists
    mr = mr
    m = Merchant.new(mr, {:id => 5, :name => "Turing School"})
    assert_instance_of Merchant, m
  end

  def test_id_is_returned
    mr = mr
    m = Merchant.new(mr, {:id => 5, :name => "Turing School"})
    assert_equal 5, m.id
  end

  def test_id_is_integer
    mr = mr
    m = Merchant.new(mr, {:id => 5.0, :name => "Turing School"})
    assert_equal 5, m.id
  end

  def test_name_is_returned
    mr = mr
    m = Merchant.new(mr, {:id => 5, :name => "Turing School"})
    assert_equal "Turing School", m.name
  end


end
