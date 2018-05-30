require './test/test_helper'
require './lib/repository'
require './lib/item'
require './lib/item_repository'
require 'bigdecimal'
require 'pry'

class ItemRepositoryTest < Minitest::Test
  def setup
    pencil = {
      :merchant_id                 => 4977,
      :name                        => "Pencil",
      :description                 => "You can use it to write things",
      :unit_price                  => BigDecimal.new(10.99, 4),
      :created_at                  => Time.now,
      :updated_at                  => Time.now,
      :unit_price_to_dollars       => 10.99
    }
    stencil = {
      :merchant_id                 => 4978,
      :name                        => "Stencil",
      :description                 => "It rhymes with pencil",
      :unit_price                  => BigDecimal.new(11.99, 4),
      :created_at                  => Time.now,
      :updated_at                  => Time.now,
      :unit_price_to_dollars       => 11.99
    }
    board = {
      :merchant_id                 => 4979,
      :name                        => "Board",
      :description                 => "It sounds like 'bored'",
      :unit_price                  => BigDecimal.new(12.99, 4),
      :created_at                  => Time.now,
      :updated_at                  => Time.now,
      :unit_price_to_dollars       => 12.99
    }
    item_repo = ItemRepository.new

    item_repo.create(pencil)
    item_repo.create(stencil)
    item_repo.create(board)

    @ir = item_repo
  end

  def test_item_repo_exists
    assert_instance_of ItemRepository, @ir
  end

  def test_item_repo_has_items
    assert_equal 3, @ir.members.count
    assert_equal "Pencil", @ir.members[0].name
    assert_equal 1, @ir.members[0].id
  end

  def test_all_returns_all_items_in_item_repo
    all_items = @ir.all

    assert_equal 3, all_items.count
    assert_equal "Pencil", all_items[0].name
    assert_equal 1, all_items[0].id
    assert_equal 2, all_items[1].id
    assert_equal "Stencil", all_items[1].name
  end

  def test_item_repo_can_find_by_id
    found = @ir.find_by_id(1)

    assert_instance_of Item, found
    assert_equal "Pencil", found.name
  end

  def test_item_repo_can_find_by_merchant_id
    by_merch_id = @ir.find_all_by_merchant_id(4978)

    assert_instance_of Item, by_merch_id[0]
    assert_equal "Stencil", by_merch_id[0].name
  end

  def test_item_repo_can_find_item_by_name
    by_name = @ir.find_by_name("Pencil")

    assert_instance_of Item, by_name
    assert_equal 1, by_name.id
  end

  def test_item_repo_can_find_by_description
    assert_equal [], @ir.find_all_with_description("lettuce")

    assert_instance_of Array, @ir.find_all_with_description("write")
    assert_equal "Pencil", @ir.find_all_with_description("write")[0].name
  end

  def test_item_repo_can_find_all_with_case_insensitive_description
    assert_instance_of Array, @ir.find_all_with_description("yOu cAn")

    assert_equal "Pencil", @ir.find_all_with_description("yOu cAn")[0].name
  end

  def test_item_repo_can_find_all_with_price
    by_price = @ir.find_all_by_price(10.99)

    assert_equal 1, by_price.count
    assert_equal "Pencil",by_price[0].name
  end

  def test_item_repo_can_find_all_items_within_a_price_range
    assert_equal 3, @ir.find_all_by_price_in_range(10..13).count
    assert_equal "Pencil", @ir.find_all_by_price_in_range(10..13)[0].name
  end

  def test_item_repo_can_create_new_items
    chair = {
      :name                        => "Chair",
      :description                 => "It rhymes with 'stair'",
      :unit_price                  => BigDecimal.new(13.99, 4),
      :created_at                  => Time.now,
      :updated_at                  => Time.now,
      :unit_price_to_dollars       => 13.99
    }
    @ir.create(chair)

    assert_equal 4, @ir.members.count
    assert_equal "Chair", @ir.members[3].name
  end

  def test_item_repo_can_update_items
    @ir.update(1, {name: "Bencil"})

    assert_equal "Bencil", @ir.members[1].name
  end

  def test_item_repo_can_delete_items_from_repository
    @ir.delete(2)

    assert_equal 2, @ir.members.count
    assert_equal 1, @ir.members[1].id
  end
end
