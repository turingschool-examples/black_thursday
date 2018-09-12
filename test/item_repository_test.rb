require './test/test_helper'
require './lib/item_repository'


class ItemRepositoryTest < Minitest::Test

  def test_it_exists
    ir = ItemRepository.new("./data/items.csv")
    assert_instance_of ItemRepository, ir
  end

  def test_it_has_items
    ir = ItemRepository.new("./data/items.csv")
    assert_equal 1367, ir.all.count

    assert_equal 263395237, ir.all.first.id
  end

  def test_it_can_find_item_by_id
    ir = ItemRepository.new("./data/items.csv")

    actual = ir.find_by_id(263395237)

    assert_instance_of Item, actual
    assert_equal "510+ RealPush Icon Set", actual.name
    assert_equal 263395237, actual.id
  end

  def test_returns_nil_when_no_match_is_found
    ir = ItemRepository.new("./data/items.csv")

    actual = ir.find_by_id(99999)

    assert_nil actual
  end

  def test_it_can_find_item_by_name
    ir = ItemRepository.new("./data/items.csv")

    actual = ir.find_by_name("510+ RealPush Icon Set")

    assert_instance_of Item, actual
    assert_equal "510+ RealPush Icon Set", actual.name
    assert_equal 263395237, actual.id
  end

  def test_it_can_find_all_with_description
    ir = ItemRepository.new("./data/items.csv")
    expected = ir.all[0]

    assert_equal expected, ir.find_all_with_description("google")[0]
    assert_equal [], ir.find_all_with_description("This doesn't exist")

    assert_equal 263395237, expected.id
  end

  def test_it_can_find_all_by_price
    ir = ItemRepository.new("./data/items.csv")
    expected = ir.all[0]


    assert_equal 41, ir.find_all_by_price(12.00).count
    assert_equal expected, ir.find_all_by_price(12.00)[0]
  end

  def test_it_can_find_all_by_price_in_range
    ir = ItemRepository.new("./test/fixtures/items.csv")
    expected = ir.all[0]
    range = (12.00..13.00)

    assert_equal ir.all[0], ir.find_all_by_price_in_range(range)[0]
    assert_equal 2, ir.find_all_by_price_in_range(range).count
    assert_equal expected, ir.find_all_by_price(12.00)[0]
  end

  def test_it_can_find_all_by_merchant_id
    ir = ItemRepository.new("./data/items.csv")
    expected = ir.all[0]

    assert_equal 1, ir.find_all_by_merchant_id(12334141).count
    assert_equal expected, ir.find_all_by_merchant_id(12334141)[0]
  end

  def test_repository_can_create_new_items
    ir = ItemRepository.new('./data/items.csv')

    new_item = ir.create(name: "thingamajigger", description: "So many things", unit_price: 3, merchant_id: 123456)

    assert_instance_of Item, new_item

    actual = ir.all.last

    assert_equal ir.find_by_name("thingamajigger"), actual
    assert_equal ir.find_by_id(263567475), actual
  end

  def test_item_attributes_can_be_updated
    ir = ItemRepository.new('./data/items.csv')

    actual = ir.find_by_id(263395237)

    assert_equal "510+ RealPush Icon Set", actual.name
    assert_equal 2, ir.find_all_by_price(11.99).count

    id = (263395237)
    attributes = {name: "510+ RealPush Icon Set VALUE PACK",
                      description: "New description",
                      unit_price: 11.99}

    ir.update(id, attributes)

    assert_equal '510+ RealPush Icon Set VALUE PACK', ir.find_by_id(id).name

    assert_equal 11.99, ir.find_by_id(id).unit_price

    assert_equal "New description", ir.find_by_id(id).description

  end

  def test_repo_can_delete_items
    ir = ItemRepository.new('./data/items.csv')

    ir.delete(263395237)

    assert_nil ir.find_by_id(263395237)
  end

end
