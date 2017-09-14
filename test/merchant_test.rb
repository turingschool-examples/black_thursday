require_relative 'test_helper'
require_relative '../lib/merchant'

class MerchantTest < Minitest::Test

  def test_it_exists
    merchant = Merchant.new({:id => 5, :name => "Turing School"})

    assert_instance_of Merchant, merchant
  end

  def test_it_has_an_id
    merchant = Merchant.new({:id => 5, :name => "Turing School"})

    assert_equal 5, merchant.id
  end

  def test_it_has_a_name
    merchant = Merchant.new({:id => 5, :name => "Turing School"})

    assert_equal "Turing School", merchant.name
  end

  def test_parent_exists_and_is_defaulted_to_nil
    merchant = Merchant.new({:id => 5, :name => "Turing School"})

    assert_nil merchant.parent
  end

end
