require './test/test_helper'
require './lib/item_repo'

class ItemRepositoryTest < Minitest::Test

  def setup
    csvfile = CSV.open "./data/items.csv", headers: true, header_converters: :symbol
    @item_repo = ItemRepository.new(csvfile, "SalesEngine")
  end

  def test_it_exists_with_items_and_engine
    assert_instance_of ItemRepository, @item_repo
    assert_equal "SalesEngine", @item_repo.engine
    assert_instance_of Hash, @item_repo.items
    assert_instance_of Item, @item_repo.items[263395237]
  end

  def test_it_can_inspect_itself
    assert_equal "#<ItemRepository 1367 rows>", @item_repo.inspect
  end

  def test_it_can_return_array_of_items
    assert_instance_of Array, @item_repo.all
    assert_instance_of Item, @item_repo.all[0]
    assert_instance_of Item, @item_repo.all[-1]
  end

  def test_can_find_by_id
    id = 263395237
    false_id = "zz09093480"

    assert_instance_of Item, @item_repo.find_by_id(id)
    assert_nil @item_repo.find_by_id(false_id)
  end

  def test_it_can_find_by_name
    name = "510+ RealPush Icon Set"
    false_name = "zz09093480"

    assert_instance_of Item, @item_repo.find_by_name(name)
    assert_equal "510+ RealPush Icon Set", @item_repo.find_by_name(name).name
    assert_nil @item_repo.find_by_name(false_name)
  end

  def test_it_can_find_all_by_description
    description = "Glitter scrabble frames \n\nAny colour glitter \nAny wording\n\nAvailable colour scrabble tiles\nPink\nBlue\nBlack\nWooden"
    false_description = "This is intentionally misleading"

    assert_instance_of Array, @item_repo.find_all_with_description(description)
    assert_instance_of Item, @item_repo.find_all_with_description(description)[0]

    assert_equal [], @item_repo.find_all_with_description(false_description)

  end

  def test_it_can_find_all_by_price
    price = 12.00
    false_price = 1000000000.00

    assert_instance_of Array, @item_repo.find_all_by_price(price)
    assert_instance_of Item, @item_repo.find_all_by_price(price)[0]
    assert_equal 41, @item_repo.find_all_by_price(price).length

    assert_equal [], @item_repo.find_all_by_price(false_price)
  end

  def test_it_can_find_all_by_price_range
    price_range = (10..20)

    assert_instance_of Array, @item_repo.find_all_by_price_in_range(price_range)
    assert_instance_of Item, @item_repo.find_all_by_price_in_range(price_range)[0]
    assert_equal 317, @item_repo.find_all_by_price_in_range(price_range).length
  end

end
