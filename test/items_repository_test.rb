require_relative 'test_helper'
require './lib/items_repository'
require 'csv'

class ItemsRepositoryTest < Minitest::Test
  def setup
    items = CSV.open './data/test_items.csv',
                      headers: true,
                      header_converters: :symbol
    @ir = ItemsRepository.new(items)
  end

  def test_items_repo_exists
    assert_instance_of ItemsRepository, @ir
  end

  def test_it_initializes_empty
    assert_equal [], @ir.all
  end

  def test_it_can_load_items
    csv = @ir.items_csv
    @ir.load_items(csv)

    assert_equal 5, @ir.all.length
  end

  def test_find_by_id
    csv = @ir.items_csv
    @ir.load_items(csv)

    nil_id = 1984
    assert_nil @ir.find_by_id(nil_id)

    real_id = 263395237
    assert_instance_of Item, @ir.find_by_id(real_id)
  end

  def test_find_by_name
    csv = @ir.items_csv
    @ir.load_items(csv)

    nil_name = "Powell's Magic Shop"
    assert_nil @ir.find_by_id(nil_name)

    real_name = 'Glitter scrabble frames'
    assert_instance_of Item, @ir.find_by_name(real_name)
  end

  def test_find_all_with_description
    csv = @ir.items_csv
    @ir.load_items(csv)

    desc_1 = 'Bob Dobbs'
    assert_equal [], @ir.find_all_with_description(desc_1)

    desc_2 = 'Givenchy'
    assert_equal 1, @ir.find_all_with_description(desc_2).length
  end

  def test_find_all_by_price
    csv = @ir.items_csv
    @ir.load_items(csv)

    price_1 = 1_000_000_000
    assert_equal [], @ir.find_all_by_price(price_1)

    price_2 = 1350
    assert_equal 1, @ir.find_all_by_price(price_2).length
  end
end
