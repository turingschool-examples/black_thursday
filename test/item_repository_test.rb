all: returns an array of all known Item instances
find_by_id: returns either nil or an instance of Item with a matching ID
find_by_name: returns either nil or an instance of Item having done a case insensitive search
find_all_with_description: returns either [] or instances of Item where the supplied string appears in the item description (case insensitive)
find_all_by_price: returns either [] or instances of Item where the supplied price exactly matches
find_all_by_price_in_range: returns either [] or instances of Item where the supplied price is in the supplied range (a single Ruby range instance is passed in)
find_all_by_merchant_id: returns either [] or instances of Item where the supplied merchant ID matches that supplied

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

    item = itemrepo.find_by_id(12337199)
    assert_instance_of Item, item
    assert_equal 12337199, item.id
  end

  def test_find_by_id_negative
    file_path = "./data/items.csv"
    salesengine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    itemrepo = ItemRepository.new(file_path, salesengine)

    item = itemrepo.find_by_id(2394023094820)
    assert_instance_of NilClass, item
  end

  def test_find_by_name_positive
    file_path = "./data/items.csv"
    salesengine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    itemrepo = ItemRepository.new(file_path, salesengine)

    item = itemrepo.find_by_name("etsygb")
    assert_instance_of Item, item
    assert_equal "EtsyGB", item.name
  end

  def test_find_by_name_negative
    file_path = "./data/items.csv"
    salesengine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    itemrepo = ItemRepository.new(file_path, salesengine)

    item = itemrepo.find_by_name("EEEEEEEEEEEYYYYYYYYthere")
    assert_instance_of NilClass, merchant
  end

  def test_find_all_with_description
    file_path = "./data/items.csv"
    salesengine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    itemrepo = ItemRepository.new(file_path, salesengine)

  def test_find_all_with_description_negative
    file_path = "./data/items.csv"
    salesengine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    itemrepo = ItemRepository.new(file_path, salesengine)

  def test_find_all_by_price
    file_path = "./data/items.csv"
    salesengine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    itemrepo = ItemRepository.new(file_path, salesengine)

  def test_find_all_by_price_negative
    file_path = "./data/items.csv"
    salesengine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    itemrepo = ItemRepository.new(file_path, salesengine)

  def test_find_all_by_price_in_range
    file_path = "./data/items.csv"
    salesengine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    itemrepo = ItemRepository.new(file_path, salesengine)

  def test_find_all_by_price_in_range_negative
    file_path = "./data/items.csv"
    salesengine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    itemrepo = ItemRepository.new(file_path, salesengine)

  def test_find_all_by_merchant_id
    file_path = "./data/items.csv"
    salesengine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    itemrepo = ItemRepository.new(file_path, salesengine)

  def test_find_all_by_merchant_id_negative
    file_path = "./data/items.csv"
    salesengine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    itemrepo = ItemRepository.new(file_path, salesengine)
