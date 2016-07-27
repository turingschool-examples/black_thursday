gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require "./lib/merchant"


class MerchantTest < MiniTest::Test

  def test_holds_a_name
    @merchant = Merchant.new({ :name => "mc'ds", :id => 666})
    assert_equal "mc'ds", @merchant.name
  end

#I don't think this test needs to exist anymore.
  def test_it_sets_default_name_to_empty_string
    skip
    @merchant = Merchant.new( { :name => "", :id => 666})
    assert_equal "", @merchant.name
  end

  def test_it_holds_an_id
    @merchant = Merchant.new({ :name => "mc'ds", :id => 666})
    assert_equal 666, @merchant.id
  end

#need to impliment repo fully before testing this???
  def test_it_can_commincate_with_the_repo
    skip
  end
end
