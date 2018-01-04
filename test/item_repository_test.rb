require_relative "test_helper"
require_relative "../lib/item_repository"

class ItemRepositoryTest < Minitest::Test

  def test_it_exists
    parent = mock("parent")
    ir = ItemRepository.new("./test/fixtures/items_fixture.csv", parent)

    assert_instance_of ItemRepository, ir
  end

  def test_it_has_parent
    parent = mock("parent")
    ir = ItemRepository.new("./test/fixtures/items_fixture.csv", parent)

    assert_equal parent, ir.parent
  end

  def test_all_returns_array_of_all_items_in_file
    parent = mock("parent")
    ir = ItemRepository.new("./test/fixtures/items_fixture.csv", parent)

    assert_instance_of Array, ir.all
    ir.all.each do |item|
      assert_instance_of Item, item
    end
    assert_equal "510+ RealPush Icon Set", ir.all[0].name
    assert_equal "263395237", ir.all[0].id
  end

  def test_find_by_id_returns_appropriate_item
    parent = mock("parent")
    ir = ItemRepository.new("./test/fixtures/items_fixture.csv", parent)

    item = ir.find_by_id("263395237")
    unknown_item = ir.find_by_id("oogabooga")

    assert_nil unknown_item
    assert_equal "510+ RealPush Icon Set", item.name
  end

  def test_find_by_name_returns_appropriate_item
    parent = mock("parent")
    ir = ItemRepository.new("./test/fixtures/items_fixture.csv", parent)

    item_1 = ir.find_by_name("Disney scrabble frames")
    item_2 = ir.find_by_name("DISNEY SCRABBLE framEs")
    unknown_item = ir.find_by_name("oogabooga")

    assert_nil unknown_item
    assert_equal "263395721", item_1.id
    assert_equal "263395721", item_2.id
  end

  def test_find_all_with_description_returns_array_of_appropriate_items
    parent = mock("parent")
    ir = ItemRepository.new("./test/fixtures/items_fixture.csv", parent)

    items_1 = ir.find_all_with_description("excellent")
    items_2 = ir.find_all_with_description("the")
    items_2_ids = items_2.map { |item| item.id }
    unknown_item = ir.find_all_with_description("oogabooga")

    assert_equal [], unknown_item
    assert_equal "263395237", items_1[0].id
    assert_equal ["263395237", "263396209", "263396255", "263396517"], items_2_ids
  end

  def test_find_all_by_price_returns_array_of_appropriate_items
    parent = mock("parent")
    ir = ItemRepository.new("./test/fixtures/items_fixture.csv", parent)

    item_1 = ir.find_all_by_price("1200")
    item_1_ids = item_1.map { |item| item.id }
    item_2 = ir.find_all_by_price("40000")
    item_2_ids = item_2.map { |item| item.id }
    unknown_item = ir.find_all_by_price("5000650")

    assert_equal [], unknown_item
    assert_equal "263395237", item_1.first.id
    assert_equal ["263395237", "263395617"], item_1_ids
    assert_equal "263396517", item_2.first.id
    assert_equal ["263396517"], item_2_ids
  end

  def test_find_all_by_price_in_range_returns_array_of_appropriate_items
    parent = mock("parent")
    ir = ItemRepository.new("./test/fixtures/items_fixture.csv", parent)

    items_1 = ir.find_all_by_price_in_range((1200..1201))
    items_1_ids = items_1.map { |item| item.id }
    items_2 = ir.find_all_by_price_in_range((39380..40000))
    items_2_ids = items_2.map { |item| item.id }
    unknown_items = ir.find_all_by_price_in_range(5000650..6000000)

    assert_equal ["263395237", "263395617"], items_1_ids
    assert_equal ["263396517"], items_2_ids
    assert_equal [], unknown_items
  end

  def test_find_all_by_merchant_id_returns_array_of_appropriate_items
    parent = mock("parent")
    ir = ItemRepository.new("./test/fixtures/items_fixture.csv", parent)

      item_1 = ir.find_all_by_merchant_id("12334185")
      item_1_ids = item_1.map { |item| item.id }
      item_2 = ir.find_all_by_merchant_id("12334195")
      item_2_ids = item_2.map { |item| item.id }
      unknown_item = ir.find_all_by_merchant_id("101011100")

      assert_equal [], unknown_item
      assert_equal "263395617", item_1.first.id
      assert_equal ["263395617", "263395721", "263396013"], item_1_ids
      assert_equal "263396255", item_2.first.id
      assert_equal ["263396255", "263396517"], item_2_ids
  end

end
