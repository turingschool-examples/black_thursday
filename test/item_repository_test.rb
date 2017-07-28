require_relative 'test_helper'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'

class ItemRepositoryTest < Minitest::Test

  def test_all
    itemrepo = ItemRepository.new("./data/items.csv", self)

    assert_instance_of Array, itemrepo.all
    assert_instance_of Item, itemrepo.all[0]
  end

  def test_find_by_id_positive
    itemrepo = ItemRepository.new("./data/items.csv", self)

    item = itemrepo.find_by_id(263395237)
    assert_instance_of Item, item
    assert_equal 263395237, item.id
  end

  def test_find_by_id_negative
    itemrepo = ItemRepository.new("./data/items.csv", self)

    item = itemrepo.find_by_id(239402309410)
    assert_instance_of NilClass, item
  end

  def test_find_by_name_positive
    itemrepo = ItemRepository.new("./data/items.csv", self)

    item = itemrepo.find_by_name("510+ RealPush Icon Set")
    assert_instance_of Item, item
    assert_equal "510+ RealPush Icon Set", item.name
  end

  def test_find_by_name_negative
    itemrepo = ItemRepository.new("./data/items.csv", self)

    item = itemrepo.find_by_name("EEEEEEEEEEEYYYYYYYYthere")
    assert_instance_of NilClass, item
  end

  def test_find_all_with_description
    itemrepo = ItemRepository.new("./data/items.csv", self)

    item = itemrepo.find_all_with_description("ship")
    assert_instance_of Array, item
    assert_instance_of Item, item[0]
  end

  def test_find_all_with_description_negative
    itemrepo = ItemRepository.new("./data/items.csv", self)

    item = itemrepo.find_all_with_description("HUZZAHLOOKITDESESOLIDDEELS")
    assert item.empty?
  end


  def test_find_all_by_price
    itemrepo = ItemRepository.new("./data/items.csv", self)
    price = 13

    item = itemrepo.find_all_by_price(price)
    assert_instance_of Array, item
    assert_instance_of Item, item[0]
  end

  def test_find_all_by_price_negative
    itemrepo = ItemRepository.new("./data/items.csv", self)

    item = itemrepo.find_all_by_price(24502394875234534987)
    assert item.empty?
  end

  def test_find_all_by_price_in_range
    itemrepo = ItemRepository.new("./data/items.csv", self)

    item = itemrepo.find_all_by_price_in_range(1000..4500)
    assert_instance_of Array, item
    assert_instance_of Item, item[0]
    assert_equal 32, item.count
  end

  def test_find_all_by_price_in_range_negative
    itemrepo = ItemRepository.new("./data/items.csv", self)

    item = itemrepo.find_all_by_price_in_range(1234234235344645645..234523452345234523452)
    assert item.empty?
    assert_equal 0, item.count
  end

  def test_find_all_by_merchant_id
    itemrepo = ItemRepository.new("./data/items.csv", self)

    item = itemrepo.find_all_by_merchant_id(12334195)
    assert_instance_of Array, item
    assert_instance_of Item, item[0]
  end

  def test_find_all_by_merchant_id_negative
    itemrepo = ItemRepository.new("./data/items.csv", self)

    item = itemrepo.find_all_by_merchant_id(2345234523498709872345)
    assert item.empty?
  end

  def test_item_repo_to_se_gets_merchant
    se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })
    items = se.items
    merchant = items.item_repo_to_se(12335119)

    assert_instance_of Merchant, merchant
  end

end
