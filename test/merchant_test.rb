require_relative 'test_helper'
require_relative '../lib/merchant'

class MerchantTest < Minitest::Test
  attr_reader :test_data

  def setup
    @test_data = {:id => 5, :name => "Turing School"}
  end

  def test_it_created_instance_of_merchant_class
    m = Merchant.new(test_data)
    assert_equal Merchant, m.class
  end

  def test_it_returns_the_id_of_the_merchant
    m = Merchant.new(test_data)
    assert_equal 5, m.id
  end

  def test_it_returns_the_name_of_the_merchant
    m = Merchant.new(test_data)
    assert_equal "Turing School", m.name
  end

  def test_it_can_return_parent_when_items_is_called
    parent = Minitest::Mock.new
    m = Merchant.new(test_data, parent)
    parent.expect(:find_items_by_merchant_id, nil, [5])
    m.items
    assert parent.verify
  end

  def test_it_can_return_parent_when_invoices_is_called
    parent = Minitest::Mock.new
    m = Merchant.new(test_data, parent)
    parent.expect(:find_invoices_by_merchant_id, nil, [5])
    m.invoices
    assert parent.verify
  end

end
