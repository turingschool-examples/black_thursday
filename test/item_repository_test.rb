require_relative 'test_helper'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'

class ItemRepositoryTest < Minitest::Test
  def setup
    files = ({:items => "./test/fixture/item_fixture.csv",
              :merchants => "./test/fixture/merchant_fixture.csv",
              :invoices => "./data/invoices.csv",})
    SalesEngine.from_csv(files).items
  end

  def test_it_exists
    assert_instance_of ItemRepository, setup
  end

  def test_repo_pulls_in_CSV_info_from_items
    assert_equal 5, setup.all.count
  end

  def test_it_returns_array_of_all_items
    assert_instance_of Array, setup.all
    assert_equal 5, setup.all.count
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
    files = ({:items => "./data/items.csv",
              :merchants => "./test/fixture/merchant_fixture.csv",
              :invoices => "./data/invoices.csv",})
    se = SalesEngine.from_csv(files).items
    item_price = se.find_all_by_price(1.00)

    assert_instance_of Array, item_price
    assert_equal 4, item_price.count
    assert_equal 1.00, item_price[2].unit_price
  end

  def test_it_can_find_all_by_price_range
    files = ({:items => "./data/items.csv",
              :merchants => "./test/fixture/merchant_fixture.csv",
              :invoices => "./data/invoices.csv",})
    se = SalesEngine.from_csv(files).items
    item_range = se.find_all_by_price_in_range(2.00..3.00)

    assert_instance_of Array, item_range
    assert_equal 38, item_range.count
  end

  def test_it_can_find_all_by_merchant_id
    files = ({:items => "./data/items.csv",
              :merchants => "./test/fixture/merchant_fixture.csv",
              :invoices => "./data/invoices.csv",})
    se = SalesEngine.from_csv(files).items
    mr = se.find_all_by_merchant_id(12334213)
    assert_equal 2, mr.count

    merch = se.find_all_by_merchant_id(12334105)
    assert_equal 3, merch.count
    assert_instance_of Array, se.find_all_by_merchant_id(12334105)
  end
end
