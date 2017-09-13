#works - 4pm, 9/12

require "./test/test_helper"
require "./lib/merchant"


class MerchantTest < Minitest::Test

  attr_reader :m

  def test_it_exists
    se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
})
    @m = Merchant.new(se, {:id => 5, :name => "Turing School"})
    assert_instance_of Merchant, m
  end

  # def test_id_is_returned
  #   @m = Merchant.new(se, {:id => 5, :name => "Turing School"})
  #   assert_equal 5, m.id
  # end
  #
  # def test_id_is_integer
  #   @m = Merchant.new(se, {:id => 5.0, :name => "Turing School"})
  #   assert_equal 5, m.id
  # end
  #
  # def test_name_is_returned
  #   @m = Merchant.new(se, {:id => 5, :name => "Turing School"})
  #   assert_equal "Turing School", m.name
  # end


end
