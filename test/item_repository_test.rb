require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'
require_relative './test_helper'
require 'pry'
require 'minitest/autorun'
require 'minitest/pride'


class ItemRepositoryTest < Minitest::Test

  def test_that_class_exist
    assert ItemRepository
  end

  def test_that_all_method_exist
    assert ItemRepository.method_defined? :all
  end

  def test_that_find_by_id_method_exist
    assert ItemRepository.method_defined? :find_by_id
  end

  def test_that_find_by_name_method_exist
    assert ItemRepository.method_defined? :find_by_name
  end

  def test_that_find_all_with_description_method_exist
    assert ItemRepository.method_defined? :find_all_with_description
  end

  def test_that_find_all_by_price_method_exist
    assert ItemRepository.method_defined? :find_all_by_price
  end

  def test_that_find_all_by_price_in_range_method_exist
    assert ItemRepository.method_defined? :find_all_by_price_in_range
  end

  def test_that_find_all_by_merchant_id_exist
    assert ItemRepository.method_defined? :find_all_by_merchant_id
  end

  def test_that_the_all_method_returns_an_array
    repo = ItemRepository.new([
      {id: 1, description: "abc"},
      {id: 2, description: "a1c"},
      {id: 3, description: "1b2"},
    ])
    assert_kind_of(Array, repo.all)
  end

  def test_that_array_has_all_elements_from_item_csv_file
    se = SalesEngine.new(
      items: [
        {id: 1, description: "abc"},
        {id: 2, description: "a1c"},
        {id: 3, description: "1b2"},
      ],
    ).items

    assert_equal 3, se.all.count
  end


  def test_that_it_will_return_an_instance_of_an_item
    repo = ItemRepository.new([
      {id: 1, description: "abc"},
      {id: 2, description: "a1c"},
      {id: 3, description: "1b2"},
    ])

    item = repo.find_by_id(1)

    assert_equal Item, item.class
  end


  def test_that_find_by_id_returns_known_item
    se = SalesEngine.new(
      items: [
        {id: 1, description: "abc"},
        {id: 2, description: "a1c"},
        {id: 3, description: "1b2"},
      ],
    ).items

    item = se.find_by_id(1)

    assert_equal 1, item.id
  end


  def test_edge_that_find_by_id_returns_known_item_even_when_inputted_as_string
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    }).items

    item = se.find_by_id("263395237")

    assert_equal "263395237", item.id
  end


  def test_edge_that_find_by_id_returns_nil_for_unknown_id
    se = SalesEngine.new(
      items: [
        {id: 1, description: "abc"},
        {id: 2, description: "a1c"},
        {id: 3, description: "1b2"},
      ],
    ).items

    item = se.find_by_id(000000000)

    assert_equal nil, item
  end

  def test_that_find_by_name_returns_a_known_item
    se = SalesEngine.new(
      items: [
        {id: 1, name: "Necklace", description: "abc"},
        {id: 2, name: "Bracelet", description: "a1c"},
        {id: 3, name: "Rings"   , description: "1b2"},
      ],
    ).items

    item = se.find_by_name("Necklace")

    assert_equal "Necklace", item.name
  end

  def test_find_by_name_returns_nil_for_unknown_item
    se = SalesEngine.new(
      items: [
        {id: 1, description: "abc"},
        {id: 2, description: "a1c"},
        {id: 3, description: "1b2"},
      ],
    ).items

    item = se.find_by_name("acdc")

    assert_equal nil, item
  end

  def test_edge_that_no_matter_where_spaces_are_placed_find_by_name_returns_known_item
    se = SalesEngine.new(
      items: [
        {id: 1, name:   "Nothing to find Here"},
        {id: 2, name:       "Will Get Ignored"},
        {id: 3, name:   "Searched With Spaces"},
      ],
    ).items

    item = se.find_by_name( "S e a r c h e d W i t h S p a c e s")

    assert_equal "Searched With Spaces", item.name
  end

  def test_edge_that_find_by_name_will_find_capitalized_known_item_name
    se = SalesEngine.new(
      items: [
        {id: 1, name: "Basketball"},
        {id: 2, name:     "Soccer"},
        {id: 3, name:   "Football"},
      ],
    ).items

    item = se.find_by_name("FOOTBALL")

    assert_equal "Football", item.name
  end

  def test_edge_that_find_by_name_will_find_known_item_typed_with_lowercase_and_upcase_letters
    se = SalesEngine.new(
      items: [
        {id: 1, name: "Basketball"},
        {id: 2, name:     "Soccer"},
        {id: 3, name:   "Football"},
      ],
    ).items
    item = se.find_by_name("S o C c E r")

    assert_equal "Soccer", item.name
    assert_equal        2, item.id
  end

  def test_that_find_all_with_description_is_an_array
    se = SalesEngine.new(
      items: [
        {id: 1, description: "abc"},
        {id: 2, description: "a1c"},
        {id: 3, description: "1b2"},
      ],
    ).items

    description = se.find_all_with_description("abc")

    assert_equal Array, description.class
  end

  def test_that_find_all_with_description_returns_empty_array_when_it_matches_no_description
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })

    ir          = se.items
    description = ir.find_all_with_description("I hate how this csv file looks on atom...")

    assert_equal [], description
  end

  def test_that_fragment_string_returns_all_matching_descriptions_for_find_all_with_description_method
    se = SalesEngine.new(
      items: [
        {id: 1, description: "abc"},
        {id: 2, description: "a1c"},
        {id: 3, description: "1b2"},
      ],
    ).items

    items = se.find_all_with_description("a")

    assert_equal  "abc", items[0].description
    assert_equal   Item, items.last.class
    assert_equal      2, items.count
  end

  def test_that_fragment_string_returns_all_matching_descriptions_for_find_all_with_description_method_v2
    ir = SalesEngine.new(
      items: [
        {id: 1, description: "abc"},
        {id: 2, description: "a1c"},
        {id: 3, description: "1b2"},
      ],
    ).items

    assert_equal [1, 2], ir.find_all_with_description("a").map(&:id)
    assert_equal [1, 3], ir.find_all_with_description("b").map(&:id)
    assert_equal [2, 3], ir.find_all_with_description("1").map(&:id)
  end

  def test_edge_that_fragment_string_returns_all_matching_descriptions_even_when_typed_weird_for_find_all_with_description_method
    ir = SalesEngine.new(
      items: [
        {id: 1, description: "AcrYlique sUr "},
        {id: 2, description: "AcrYlique exécuTée"},
        {id: 3, description: "1b2"},
      ],
    ).items

    assert_equal [1, 2], ir.find_all_with_description("a").map(&:id)
  end

  def test_edge_that_fragment_string_returns_all_matching_descriptions_even_when_typed_weird_with_spaces_for_find_all_with_description_method
    ir = SalesEngine.new(
      items: [
        {id: 1, description: "AcrYlique sUr "},
        {id: 2, description: "AcrYlique exécuTée"},
        {id: 3, description: "1b2"},
      ],
    ).items

    assert_equal [1,2], ir.find_all_with_description("AcrY lique ").map(&:id)
  end

  def test_that_find_all_by_price_is_an_array
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })
    ir    = se.items
    price = ir.find_all_by_price(10.99)

    assert_equal Array, price.class
  end


  def test_that_find_all_by_price_returns_values
    ir = SalesEngine.new(
      items: [
        {id: 1, unit_price: "1186"},
        {id: 2, unit_price: "1099"},
        {id: 3, unit_price: "11099"},
        {id: 4, unit_price: "11099"},
        {id: 5, unit_price: "11099"},
      ],
    ).items
    result = ir.find_all_by_price(110.99)

    assert_equal [3, 4, 5], result.map(&:id)
  end

  def test_that_find_all_by_price_returns_empty_array_for_absurd_price
    ir = SalesEngine.new(
      items: [
        {id: 1, unit_price: "1186"},
        {id: 2, unit_price: "1099"},
        {id: 3, unit_price: "11099"},
      ],
    ).items

    assert_equal [],  ir.find_all_by_price(12345678.99)
  end

  def test_that_find_all_by_price_will_work_with_dollar_signs_and_decimals
    ir = SalesEngine.new(
      items: [
        {id: 1, unit_price: "1186"},
        {id: 2, unit_price: "1099"},
        {id: 3, unit_price: "11099"},
      ],
    ).items

    assert_equal ["1099"], ir.find_all_by_price("$10.99").map(&:unit_price)
  end

  def test_that_find_all_by_price_in_range_is_an_array
    ir = SalesEngine.new(
      items: [
        {id: 1, unit_price: "1186"},
        {id: 2, unit_price: "1099"},
        {id: 3, unit_price: "11099"},
      ],
    ).items
    num   = (1..10)
    price = ir.find_all_by_price_in_range(num)

    assert_equal Array, price.class
  end

  def test_that_find_all_by_price_in_range_returns_items_within_inputted_price_range
    ir = SalesEngine.new(items: [
        {id: 1, unit_price: "1186"},
        {id: 2, unit_price: "1099"},
        {id: 3, unit_price: "11099"},
        {id: 4, unit_price: "10990"},
      ]).items

    result = ir.find_all_by_price_in_range(Range.new(10.01,12))

    assert_equal [1,2], result.map(&:id)
  end

  def test_that_find_all_by_price_in_range_returns_empty_array_for_unknown_price_range
    ir = SalesEngine.new(items: [
        {id: 1, unit_price: "1186"},
        {id: 2, unit_price: "1099"},
        {id: 3, unit_price: "11099"},
        {id: 4, unit_price: "10990"},
      ]).items

    assert_equal [], ir.find_all_by_price_in_range(1..10)
  end

  def test_that_find_all_by_merchant_id_is_an_array
    ir = SalesEngine.new(items: [
        {id: 1, merchant_id: "11860"},
        {id: 2, merchant_id: "10990"},
        {id: 3, merchant_id: "110990"},
        {id: 4, merchant_id: "109900"},
      ]).items
    price = ir.find_all_by_merchant_id(10)

    assert_equal Array, price.class
  end

  def test_that_find_all_by_merchant_id_returns_id_matches
    ir = SalesEngine.new(items: [
        {id: 1, merchant_id: "11860"},
        {id: 2, merchant_id: "10990"},
        {id: 3, merchant_id: "10"},
        {id: 4, merchant_id: "10"},
      ]).items
    price = ir.find_all_by_merchant_id(10)

    assert_equal ["10", "10"], price.map(&:merchant_id)
  end

  def test_that_find_all_by_merchant_id_returns_empty_array_when_no_matches_are_found
    ir = SalesEngine.new(items: [
        {id: 1, merchant_id: "11860"},
        {id: 2, merchant_id: "10990"},
        {id: 3, merchant_id: "110990"},
        {id: 4, merchant_id: "109900"},
      ]).items
    price = ir.find_all_by_merchant_id(00000)
    assert_equal [], price
  end


end
