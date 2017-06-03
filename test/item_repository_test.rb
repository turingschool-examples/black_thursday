require "minitest/autorun"
require "minitest/pride"
require "csv"
require_relative "../lib/item_repository"
require_relative "../lib/sales_engine"
require "pry"

class ItemRepositoryTest < Minitest::Test
  attr_reader :item_repo
  def setup
    small_csv_paths = {
                        :items     => "./test/data/small_item_set.csv",
                        :merchants => "./test/data/merchant_sample.csv",
                      }
    engine = SalesEngine.from_csv(small_csv_paths)
    csv = CSV.open('./test/data/small_item_set.csv', :headers => true, :header_converters => :symbol)

    @item_repo = ItemRepository.new(csv, engine)
  end

  def test_it_exists_and_populates_items_automatically
    assert_instance_of ItemRepository, item_repo
    assert_instance_of Item, item_repo.items[item_repo.items.keys.sample]
    assert_equal 6, item_repo.items.keys.length
  end

  def test_it_can_add_items
    csv = CSV.open('./test/data/small_item_set.csv', :headers => true, :header_converters => :symbol)

    item_repo.items.clear

    item_repo.add(csv)
    random_item_key = item_repo.items.keys.sample

    assert_instance_of Item, item_repo.items[random_item_key]
    assert_equal 6, item_repo.items.keys.length
  end

  def test_it_can_return_all_item_instances
    actual = item_repo.all
    assert_equal 6, actual.length
    assert_instance_of Item, actual.sample
  end

  def test_it_can_find_item_by_id
    id = 263396279

    assert_instance_of Item, item_repo.find_by_id(id)
    assert_equal id, item_repo.find_by_id(id).id
  end

  def test_returns_nil_for_invalid_id
    id = "2412341234"

    assert_nil item_repo.find_by_id(id)
  end

  def test_can_find_item_by_name
    name = "Eule - Topflappen, handgehäkelt, Paar"

    assert_instance_of Item, item_repo.find_by_name(name)
    assert_equal name, item_repo.find_by_name(name).name
  end

  def test_can_find_all_items_with_a_description
    actual = item_repo.find_all_with_description('Handmade')
    assert_instance_of Array, actual
    assert_instance_of Item, actual.sample
    assert_equal 2, actual.length
  end

  def test_it_returns_empty_array_for_silly_string
    actual = item_repo.find_all_with_description('quetzocatl')
    assert_instance_of Array, actual
    assert_equal [], actual
  end

  def test_it_can_find_all_items_with_certain_price
    actual = item_repo.find_all_by_price(130.00)

    assert_instance_of Array, actual
    assert_instance_of Item, actual.sample
    assert_equal 2, actual.length
  end

  def test_it_can_find_all_items_in_price_range
    actual = item_repo.find_all_by_price_in_range((1..90.00))

    assert_instance_of Array, actual
    assert_instance_of Item, actual.sample
    assert_equal 2, actual.length
  end

  def test_it_can_find_all_items_by_merch_id
    actual = item_repo.find_all_by_merchant_id(12334213)

    assert_instance_of Array, actual
    assert_instance_of Item, actual.sample
    assert_equal 2, actual.length
  end

  def test_it_knows_about_parent_sales_engine
    assert_instance_of SalesEngine,item_repo.engine
  end

  def test_it_can_get_merchant_by_item_from_sales_engine
    actual = item_repo.merchant_by_item(12334113)

    assert_instance_of Merchant, actual
    assert_equal 12334113, actual.id
  end

end
