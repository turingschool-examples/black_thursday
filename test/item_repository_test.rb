require_relative 'test_helper'

# TO DO  - change these to require require_relative
require './lib/item'
require './lib/item_repository'


class ItemRepositoryTest < Minitest::Test

  def setup
    @path = './data/items.csv'
    @repo = ItemRepository.new(@path)

    # -- First Item's information --
    @first_item = @repo.all[0]
    # NOTE - The description is only an except.
    # NOTE - DO NOT try to match the description value (@repo.all[0].description)
    @headers = [:id, :created_at, :merchant_id, :name, :description, :unit_price, :updated_at]
    # --- CSVParse created hash set ---
    @key = :"263395237"
    @value = {
              :name           => "510+ RealPush Icon Set",
              :description    => "You&#39;ve got a total socialmedia iconset!", # NOTE - excerpt!
              :unit_price     => "1200",
              :merchant_id    => "12334141",
              :created_at     => "2016-01-11 09:34:06 UTC",
              :updated_at     => "2007-06-04 21:35:10 UTC"
    }
    @expected_form_from_csv_parse = {@key => @value}
    # -----------------------------------
  end

  def test_it_exists
    assert_instance_of ItemRepository, @repo
  end

  def test_it_makes_and_gets_items
    assert_instance_of Array, @repo.all
    assert_instance_of Item,  @repo.all[0]
    assert_instance_of Item,  @repo.all[1000]
  end

  def test_it_makes_items
    big_decimal = BigDecimal.new(1200, 4)
    assert_equal "510+ RealPush Icon Set",  @first_item.name
    assert_equal big_decimal,               @first_item.unit_price
    assert_equal "12334141",                @first_item.merchant_id
    assert_equal "2016-01-11 09:34:06 UTC", @first_item.created_at
    assert_equal "2007-06-04 21:35:10 UTC", @first_item.updated_at
  end

  def test_it_makes_a_formatted_hash
    # -- The new hash needs an additional column --
    new_column = {:id => 263395237}
    new_hash = new_column.merge(@value.dup)
    assert_equal new_hash, @repo.make_hash(@key, @value)
  end

  def test_it_gets_all_merchants
    assert_equal 1367, @repo.all.count
    assert_equal @repo.items, @repo.all
  end

  def test_it_can_find_by_item_id
    found = @repo.find_by_id(263395237)
    assert_equal @first_item.id, found.id
  end

  def test_it_can_find_by_case_insensitive_name
    found = @repo.find_by_name("510+ RealPush Icon Set")
    assert_equal @first_item.name, found.name
  end

  def test_it_can_find_all_with_similar_description
    # -- only one has this string --
    found_1 = @repo.find_all_with_description("You&#39;ve got a total socialmedia iconset!")
    assert_equal 1, found_1.count
    assert_equal @first_item.description, found_1[0].description
    # -- many have this string --
    found_many = @repo.find_all_with_description("You")
    assert_equal @first_item.description, found_many[0].description
    assert_equal true, found_many[500].description.include?("You".downcase)
    # -- none have this string --
    found_none = @repo.find_all_with_description("zzzzzzzzz")
    assert_equal [], found_none
  end

  def test_it_can_find_an_item_by_unit_price
    big_decimal = BigDecimal.new("1200", 4)
    found_1 = @repo.find_all_by_price(1200)
    found_2 = @repo.find_all_by_price("1200")
    found_3 = @repo.find_all_by_price(big_decimal)
    # -- Handles multiple types of price input --
    same = found_1 == found_2 && found_1 == found_3
    assert_equal true, same
  end

  def test_it_can_find_items_within_same_price_range
    found = @repo.find_all_by_price_in_range((100..200))
    assert_operator   0, :<, found.count
    # -- first example --
    assert_operator  99, :<, found.last.unit_price
    assert_operator 201, :>, found.last.unit_price
    # -- last example --
    assert_operator  99, :<, found.first.unit_price
    assert_operator 201, :>, found.first.unit_price
  end

  def test_it_can_find_all_items_with_same_merchant_id
    found_1 = @repo.find_all_by_merchant_id("12334141")
    found_2 = @repo.find_all_by_merchant_id(12334141)
    assert_operator 1, :<=, found_1.count
    assert_equal "12334141", found_1[0].merchant_id
    skip
    # TO DO - We have to update all objects to hold correct data type
    assert_equal 12334141, found_2[0].merchant_id
  end

end
