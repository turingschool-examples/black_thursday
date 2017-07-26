require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repository'
require './lib/sales_engine'

class ItemRepositoryTest < Minitest::Test
  def test_all
    file_path = "./data/items.csv"
    salesengine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    itemrepo = ItemRepository.new(file_path, salesengine)

    assert_instance_of Array, itemrepo.all
    assert_instance_of Item, itemrepo.all[0]
  end

  def test_find_by_id_positive
    file_path = "./data/items.csv"
    salesengine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    itemrepo = ItemRepository.new(file_path, salesengine)

    item = itemrepo.find_by_id(263395237)
    assert_instance_of Item, item
    assert_equal 263395237, item.id
  end

  def test_find_by_id_negative
    file_path = "./data/items.csv"
    salesengine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    itemrepo = ItemRepository.new(file_path, salesengine)

    item = itemrepo.find_by_id(239402309410)
    assert_instance_of NilClass, item
  end

  def test_find_by_name_positive
    file_path = "./data/items.csv"
    salesengine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    itemrepo = ItemRepository.new(file_path, salesengine)

    item = itemrepo.find_by_name("510+ RealPush Icon Set")
    assert_instance_of Item, item
    assert_equal "510+ RealPush Icon Set", item.name
  end

  def test_find_by_name_negative
    file_path = "./data/items.csv"
    salesengine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    itemrepo = ItemRepository.new(file_path, salesengine)

    item = itemrepo.find_by_name("EEEEEEEEEEEYYYYYYYYthere")
    assert_instance_of NilClass, item
  end

  def test_find_all_with_description
    file_path = "./data/items.csv"
    salesengine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    itemrepo = ItemRepository.new(file_path, salesengine)

    item = itemrepo.find_all_with_description("ship")
    assert_instance_of Array, item
    assert_instance_of Item, item[0]
  end

  def test_find_all_with_description_negative
    file_path = "./data/items.csv"
    salesengine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    itemrepo = ItemRepository.new(file_path, salesengine)

    item = itemrepo.find_all_with_description("HUZZAHLOOKITDESESOLIDDEELS")
    assert item.empty?
  end


  def test_find_all_by_price
    file_path = "./data/items.csv"
    salesengine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    itemrepo = ItemRepository.new(file_path, salesengine)

    item = itemrepo.find_all_by_price(2999)
    assert_instance_of Array, item
    assert_instance_of Item, item[0]
  end

  def test_find_all_by_price_negative
    file_path = "./data/items.csv"
    salesengine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    itemrepo = ItemRepository.new(file_path, salesengine)

    item = itemrepo.find_all_by_price(24502394875234534987)
    assert item.empty?
  end

  def test_find_all_by_price_in_range
    file_path = "./data/items.csv"
    salesengine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    itemrepo = ItemRepository.new(file_path, salesengine)

    item = itemrepo.find_all_by_price_in_range(1000, 4500)
    assert_instance_of Array, item
    assert_instance_of Item, item[0]
  end

  def test_find_all_by_price_in_range_negative
    file_path = "./data/items.csv"
    salesengine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    itemrepo = ItemRepository.new(file_path, salesengine)

    item = itemrepo.find_all_by_price_in_range(1234234235344645645, 234523452345234523452)
    assert item.empty?
  end

  def test_find_all_by_merchant_id
    file_path = "./data/items.csv"
    salesengine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    itemrepo = ItemRepository.new(file_path, salesengine)

    item = itemrepo.find_all_by_merchant_id(12334195)
    assert_instance_of Array, item
    assert_instance_of Item, item[0]
  end

  def test_find_all_by_merchant_id_negative
    file_path = "./data/items.csv"
    salesengine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    itemrepo = ItemRepository.new(file_path, salesengine)

    item = itemrepo.find_all_by_merchant_id(2345234523498709872345)
    assert item.empty?
  end
end
