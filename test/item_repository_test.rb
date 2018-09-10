require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repository'
require './lib/sales_engine'

class ItemRepositoryTest < Minitest::Test

  def test_that_it_exists
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv"
    })

    ir = se.items
    assert_instance_of ItemRepository, ir
  end

  def test_that_it_loads_the_repository_of_merchants
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv"
    })

    ir = se.items
    actual = ir.items_array[0]

    assert_instance_of Item , actual
  end

  def test_the_all_method_returns_an_array_of__all_instances_of_merchant
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv"
    })

    ir = se.items
    assert_equal 1367, ir.all.count
  end

  def test_the_find_by_id_method_finds_merchants_by_id
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv"
    })

    ir = se.items
    findings = ir.find_by_id(263399749)
    actual = findings[0].name
    assert_equal 'Grande toile', actual
  end

  def test_the_find_by_name_method_finds_merchants_by_name
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv"
    })
    ir = se.items
    findings = ir.find_by_name("Grande toile")
    actual = findings[0].name

    assert_equal "Grande toile", actual
  end

  def test_the_find_by_name_method_returns_nil_if_not_found
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv"
    })
    ir = se.items
    actual = ir.find_by_name("Mcdonalds")

    assert_nil actual
  end

  def test_that_the_find_all_with_description_finds_items_by_fragment
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv"
    })

    ir = se.items
    item = ir.find_all_with_description('Handmade Bracelet')

    expected = 'Exotic Beaded Women&#39;s or Men&#39;s Handmade Bracelet or Anklet'
    actual = item[0].name

    assert_equal expected, actual
  end

  def test_that_find_all_price_searches_based_on_price
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv"
    })

    ir = se.items
    item = ir.find_all_by_price(60000)

    expected = 'Introspection virginalle'
    actual = item[0].name

    assert_equal expected, actual
  end

  def test_that_find_all_by_price_in_range_selects_items_in_range
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv"
    })

    ir = se.items
    items = ir.find_all_by_price_in_range(60000..65000)

    actual = items.count

    assert_equal 10, actual
  end

  def test_that_find_all_by_id_selects_items_in_by_id_number
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv"
    })

    ir = se.items
    items = ir.find_all_by_merchant_id(12334195)
    expected = 12334195

    assert_equal expected, items[0].merchant_id
    assert_equal expected, items[1].merchant_id
    assert_equal expected, items[2].merchant_id
  end

  def test_the_find_by_id_method_returns_nil_if_not_found
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv"
    })
    ir = se.items
    actual = ir.find_by_id(6457654)

    assert_nil actual
  end

  def test_that_create_method_creates_new_items
    ir = ItemRepository.new([])

    ir.create({
    :name        => "Pencil",
    :description => "You can use it to write things",
    :unit_price  => BigDecimal.new(10.99,4),
    :merchant_id => 2
    })
    id_number = ir.items_array[0].id
    name = ir.items_array[0].name

    assert_equal 1, id_number
    assert_equal 'Pencil', name
  end

  def test_that_delete_method_deletes_items
    ir = ItemRepository.new([])

    ir.create({
    :name        => "Pencil",
    :description => "You can use it to write things",
    :unit_price  => BigDecimal.new(10.99,4),
    :merchant_id => 2
    })
    number = ir.all.count
    assert_equal 1, number
    ir.delete(0)
    number = ir.all.count

    assert_equal 0 , number
  end

  def test_update
    ir = ItemRepository.new([])
    ir.create({
    :name        => "Pencil",
    :description => "You can use it to write things",
    :unit_price  => BigDecimal.new(10.99,4),
    :merchant_id => 2
    })
    ir.update(1, {
    :id          => 1,
    :name        => "Unleaded Pencil",
    :description => "You can use it to write things",
    :unit_price  => BigDecimal.new(9.99,4),
    })
    created_date = ir.items_array[0].created_at
    updated_date = ir.items_array[0].updated_at
    name = ir.items_array[0].name
    boolean = created_date != updated_date

    assert boolean
    assert_equal 'Unleaded Pencil', name
  end

end
