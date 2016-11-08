require_relative 'test_helper'
require_relative '../lib/merchant'

class MerchantTest < Minitest::Test

  attr_reader :parent, :m

  def setup
    @parent = Minitest::Mock.new
    @m = Merchant.new({:id => 1,:name => "Bob", :created_at => "2009-02-01"}, parent) 
  end

  def test_that_merchant_stores_id_and_name
    assert_equal 1, m.id
    assert_equal "Bob", m.name
    assert_equal 2009, m.created_at.year
  end

  def test_it_calls_its_parents_when_looking_for_items
    parent.expect(:find_items_by_merchant_id, nil, [1])
    m.items
    parent.verify
  end

  def test_it_calls_its_parents_when_looking_for_invoices
    parent.expect(:find_invoices_by_merchant_id, nil, [1])
    m.invoices
    parent.verify
  end

end