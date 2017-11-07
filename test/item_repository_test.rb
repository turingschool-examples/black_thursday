require_relative 'test_helper'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'

class ItemRepositoryTest < Minitest::Test
  def setup
    files = ({:invoices => "./test/fixture/invoice_fixture.csv",
      :items => "./test/fixture/item_fixture.csv",
      :merchants => "./test/fixture/merchant_fixture.csv",
      :invoice_items => "./test/fixture/invoice_item_fixture.csv",
      :transactions => "./test/fixture/transaction_fixture.csv",
      :customers => "./test/fixture/customer_fixture.csv"})
    SalesEngine.from_csv(files).items
  end

  def test_it_exists
    assert_instance_of ItemRepository, setup
  end

  def test_repo_pulls_in_CSV_info_from_items
    assert_equal 7, setup.all.count
  end

  def test_it_returns_array_of_all_items
    assert_instance_of Array, setup.all
    assert_equal 7, setup.all.count
  end

  def test_find_by_id
    assert_instance_of Item, setup.find_by_id(263395237)
    assert_equal 263395237, setup.find_by_id(263395237).id
  end

  def test_it_can_find_by_name
    item_name = setup.find_by_name("Vogue Paris Original Givenchy 2307")
    assert_equal "Vogue Paris Original Givenchy 2307", item_name.name
  end

  def test_it_can_find_all_with_description
    item_des = setup.find_all_with_description("Paris")

    assert_instance_of Array, item_des
    assert_equal 1, item_des.count
  end

  def test_it_can_find_all_by_price
    item_price = setup.find_all_by_price(7.00)

    assert_instance_of Array, item_price
    assert_equal 1, item_price.count
    assert_equal 7.00, item_price[0].unit_price
  end

  def test_it_can_find_all_by_price_range
    item_range = setup.find_all_by_price_in_range(2.00..10.00)

    assert_instance_of Array, item_range
    assert_equal 1, item_range.count
  end

  def test_it_can_find_all_by_merchant_id
    mr = setup.find_all_by_merchant_id(12334185)
    assert_equal 3, mr.count

    merch = setup.find_all_by_merchant_id(12334389)
    assert_equal 1, merch.count
    assert_instance_of Array, setup.find_all_by_merchant_id(12334389)
  end
end
