require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'

class MerchantTest < MiniTest::Test

  def test_it_exists
    repo = "repo"
    merchant = Merchant.new({:id => 5, :name => "Turing School"}, repo)

    assert_instance_of Merchant, merchant
  end

  def test_it_has_readable_attributes
    repo = "repo"
    merchant = Merchant.new({:id => 5, :name => "Turing School"}, repo)

    assert_equal 5, merchant.id
    assert_equal "Turing School", merchant.name
    assert_equal "repo", merchant.repo
  end

  def test_you_can_update_merchant
    repo = "repo"
    merchant = Merchant.new({:id => 5, :name => "Turing School"}, repo)
    merchant.update(:name, "Turing School of Software and Design")

    assert_equal "Turing School of Software and Design", merchant.name

  end

end
