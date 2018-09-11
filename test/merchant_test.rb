require_relative './test_helper'
require_relative '../lib/merchant'

class MerchantTest < Minitest::Test

  def test_it_exists
    m = Merchant.new({:id => 5, :name => "Turing School"})

    assert_instance_of Merchant, m
  end

  def test_it_can_split_csv
    mr = MerchantRepository.new("./data/test_merchants.csv")

    assert_equal "Shopin1901", mr.find_by_id(1).name
  end

  def test_it_has_attributes
    m = Merchant.new({:id => 5, :name => "Turing School"})

    assert_equal 5, m.id
    assert_equal "Turing School", m.name
  end

end
