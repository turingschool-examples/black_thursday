require './test/test_helper'

class MerchantTest < Minitest::Test

  def test_class_exists
    assert_instance_of Merchant, Merchant.new({id:"12334105",  name:"Shopin1901", created_at:"2010-12-10", updated_at:"2011-12-04"})
  end

  def test_id
    m = Merchant.new({id:"12334105",  name:"Shopin1901", created_at:"2010-12-10", updated_at:"2011-12-04"})
    assert_equal 12334105, m.id
  end

  def test_name
    m = Merchant.new({id:"12334105",  name:"Shopin1901", created_at:"2010-12-10", updated_at:"2011-12-04"})
    assert_equal "Shopin1901", m.name
  end

  def test_find_items_by_merchant_id
    se = SalesEngine.from_csv({items: './test/fixtures/items_match_merchant_id.csv', merchants: './test/fixtures/merchants_test_data.csv'})
    merchant = se.merchants.find_by_id(12334105)
    expected_number_of_items = 3

    assert_equal expected_number_of_items, (merchant.items).length
  end

end
