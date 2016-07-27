gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require "./lib/merchant"


class MerchantTest < MiniTest::Test

  def test_holds_a_name
    @merchant = Merchant.new(["12334105", "Shopin1901", "2010-12-10", "2011-12-04"])

    assert_equal "mc'ds", @merchant.name
  end
  def test_it_sets_default_name_to_empty_string
    @merchant = Merchant.new( 666, "string")

    assert_equal "", @merchant.name
  end
  def test_it_holds_an_id
    @merchant = Merchant.new("mc'ds", 666, "string")

    assert_equal 666, @merchant.id
  end
  def test_it_will_recieve_a_merchant_repo
    @merchant = Merchant.new("mc'ds", 666, "string")

    assert_equal "string", @merchant.repo
  end

  def test_it_can_commincate_with_the_repo
    skip
  end
end
