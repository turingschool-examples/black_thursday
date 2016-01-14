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
    skip
    assert ItemRepository.method_defined? :find_all_by_price_in_range
  end

  def test_that_find_all_by_merchant_id_exist
    skip
    assert ItemRepository.method_defined? :find_all_by_merchant_id
  end

  def test_that_the_all_method_returns_an_array
    se = SalesEngine.new(
            items: [
              {id: 1, description: "abc"},
              {id: 2, description: "a1c"},
              {id: 3, description: "1b2"},
            ],
          ).items

    assert_kind_of(Array, se.all)
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
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    }).items

    item = se.find_by_name("510+ RealPush Icon Set")

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

  def test_find_by_name_returns_a_known_item
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
    binding.pry
    assert_equal [1, 2], ir.find_all_with_description("a").map(&:id)
  end

  def test_edge_that_fragment_string_returns_all_matching_descriptions_even_when_typed_weird_with_spaces_for_find_all_with_description_method
    #case insensitive test
    skip
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })
    ir          = se.items
    description = ir.find_all_with_description("AcrY lique s Ur to Ile ex écuTée")
    #this should return a couple matches, so run the test to see the real answer
    assert_equal ["a"], description
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

  def test_that_find_all_by_price_returns_value
    ir = SalesEngine.new(
      items: [
        {id: 1, unit_price: "1186"},
        {id: 2, unit_price: "1099"},
        {id: 3, unit_price: "11099"},
      ],
    ).items
    result = ir.find_all_by_price(10.99)

    assert_equal [2], result.map(&:id)
  end

  def test_that_find_all_by_price_returns_empty_array_for_absurd_price
    skip
    #im not too sure how this will work with the BigDecimal so be cautious
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })
    ir    = se.items
    price = ir.find_all_by_price(12345678.99)

    assert_equal [], price
  end

  def test_that_find_all_by_price_in_range_is_an_array
    skip
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })
    ir    = se.items
    num   = (1..10)
    #reread readme to figure this out
    price = ir.find_all_by_price_in_range(num)
    #we will need to require the BigDecimal class from Item
    assert_equal Array, price.class
  end

  def test_that_find_all_by_price_in_range_returns_items_within_inputted_price_range
    skip
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })
    ir    = se.items
    #reread readme to figure this out
    num   = (10..15)
    price = ir.find_all_by_price_in_range(num)
    #we will need to require the BigDecimal class from Item
    assert_equal ["items with prices from $10 through $15 will pop in here"], price
  end

  def test_that_find_all_by_price_in_range_returns_empty_array_for_unknown_price_range
    skip
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })
    ir    = se.items
    #reread readme to figure this out
    num   = (1..2)
    price = ir.find_all_by_price_in_range(num)
    #we will need to require the BigDecimal class from Item
    assert_equal [], price
  end

  def test_that_find_all_by_merchant_id_is_an_array
    skip
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })
    ir    = se.items
    price = ir.find_all_by_merchant_id(263395)
    #given the supplied fragment of an id it should output matches
    assert_equal Array, price.class
  end

  def test_that_find_all_by_merchant_id_returns_id_matches
    skip
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })
    ir    = se.items
    price = ir.find_all_by_merchant_id(263395)
    #given the supplied fragment of an id it should output matches
    assert_equal ["here a couple of id matches will pop up"], price
  end

  def test_that_find_all_by_merchant_id_returns_empty_array_when_no_matches_are_found
    skip
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })
    ir    = se.items
    price = ir.find_all_by_merchant_id(00000)
    #given the supplied fragment of an id it should output matches
    assert_equal [], price
  end


end
