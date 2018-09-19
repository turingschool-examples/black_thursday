require_relative 'test_helper'

require_relative '../lib/sales_engine'
require_relative '../lib/item_repository'
require_relative '../lib/item'


class ItemRepositoryTest < Minitest::Test

  def setup
    path = {:items => './data/items.csv'}
    @repo = SalesEngine.from_csv(path).items
    @first_item = @repo.all[0]
    # ===== Item Examples =================
    # NOTE - The description is only an except.
    # NOTE - DO NOT try to match the description value (@repo.all[0].description)
    # 263395237,510+ RealPush Icon Set,"You&#39;ve got a total socialmedia iconset! # 1200,12334141,2016-01-11 09:34:06 UTC,2007-06-04 21:35:10 UTC
    @item_1_hash = { :"263395237" => { name:        "510+ RealPush Icon Set",
                                      description: "You&#39;ve got a total socialmedia iconset!", # Excerpt!
                                      unit_price:  "1200",
                                      merchant_id: "12334141",
                                      created_at:  "2016-01-11 09:34:06 UTC",
                                      updated_at:  "2007-06-04 21:35:10 UTC"
                                     } }
    @key    = @item_1_hash.keys.first
    @values = @item_1_hash.values.first
  end

  def test_it_exists
    assert_instance_of ItemRepository, @repo
  end

  def test_it_gets_attributes
    # --- Read Only ---
    assert_instance_of Array, @repo.all
    assert_instance_of Item, @repo.all[0]
    assert_equal @repo.all.count, @repo.all.uniq.count
    assert_equal 1367, @repo.all.count
  end

  def test_it_makes_items
    # This test is skipped because it will affect other tests.
    skip
    @repo.make_items
    assert_equal 1367 * 2, @repo.all.count
  end


  def test_it_makes_a_formatted_hash
    # -- The new hash needs an additional column --
    new_column = {:id => 263395237}
    new_hash = new_column.merge(@values.dup)
    assert_equal new_hash, @repo.make_hash(@key, @values)
  end


  # --- Find By ---

  def test_it_can_find_by_item_id
    assert_nil @repo.find_by_id(000)
    found = @repo.find_by_id(263395237)
    assert_instance_of Item, found
    assert_equal 263395237, found.id
  end

  def test_it_can_find_by_case_insensitive_name
    found = @repo.find_by_name("510+ RealPush Icon Set")
    assert_equal @first_item.name, found.name
  end

  def test_it_can_find_all_with_similar_description
    # -- none have this string --
    found_none = @repo.find_all_with_description("zzzzzzzzz")
    assert_equal [], found_none
    # -- only one has this string --
    found_1 = @repo.find_all_with_description("You&#39;ve got a total socialmedia iconset!")
    assert_equal 1, found_1.count
    assert_equal @first_item.description, found_1[0].description
    # -- many have this string --
    found_many = @repo.find_all_with_description("You")
    assert_equal @first_item.description, found_many[0].description
    assert_equal true, found_many[500].description.include?("You".downcase)
  end

  def test_it_can_find_an_item_by_unit_price
    # -- none have this price --
    found_none = @repo.find_all_by_price(0)
    assert_equal [], found_none
    # -- Handles multiple types of price input --
    big_decimal = BigDecimal.new("12.00", 4)
    found = @repo.find_all_by_price(12.00)
    assert_instance_of Array, found
    assert_equal big_decimal, found.first.unit_price
  end

  def test_it_can_find_items_within_same_price_range
    # -- none have this price --
    found_none = @repo.find_all_by_price_in_range((0..0.1))
    assert_equal [], found_none
    # -- results --
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
    # -- none have this id --
    found_none = @repo.find_all_by_merchant_id(000)
    assert_equal [], found_none
    # --- Merchant 1 ---
    found_1 = @repo.find_all_by_merchant_id(12334141)
    assert_operator 1, :<=, found_1.count
    assert_equal 12334141, found_1[0].merchant_id
    # --- Merchant 2 ---
    found_2 = @repo.find_all_by_merchant_id(12334185)
    assert_operator 1, :<=, found_2.count
    assert_equal 12334185, found_2[0].merchant_id
  end


  # --- CRUD ---

  def test_it_creates_an_item
    all_before = @repo.all.count.to_s.to_i
    assert_equal 1367, all_before
    hash = {name: "something"}
    @repo.create(hash)
    all_after = @repo.all.count.to_s.to_i
    assert_equal 1368, all_after
    assert_equal 263567475, @repo.all.last.id
  end

  def test_it_updates_an_item
    found = @repo.find_by_id(263395237)
    assert_equal 12.00, found.unit_price
    hash = {unit_price: 13.00}
    @repo.update(263395237, hash)
    assert_equal 13.00, found.unit_price
    assert_instance_of BigDecimal, found.unit_price
  end

  def test_it_deletes_an_item
    found = @repo.find_by_id(263395237)
    assert_instance_of Item, found
    @repo.delete(263395237)
    not_found = @repo.find_by_id(263395237)
    assert_nil not_found
  end







end
