require_relative 'test_helper'
require_relative '../lib/merchant'
require_relative '../lib/sales_engine'

class MerchantTest < Minitest::Test
  def test_it_exists
    merchant = Merchant.new({:id => 5, :name => "Turing School"})

    assert_instance_of Merchant, merchant
  end

  def test_it_has_an_id
    merchant = Merchant.new({:id => 5, :name => "Turing School"})

    assert_equal 5, merchant.id
  end

  def test_finding_items_associated_with_merchant
    information = {:items => './test/fixtures/item_repository_abreviated.csv',
                   :merchants => './test/fixtures/merchants_list_truncated.csv'}
    sales_engine = SalesEngine.from_csv(information)
    merchant = sales_engine.merchants.find_by_id(123_341_12)

    assert_instance_of Array, merchant.items
    assert_instance_of Item, merchant.items.first
    assert_equal 263_410_021, merchant.items.first.id
  end
end
