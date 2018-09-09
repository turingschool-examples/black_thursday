
# TO DO - Add these to simplecov
require 'minitest/autorun'
require 'minitest/pride'

require 'pry'

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
    assert_equal "510+ RealPush Icon Set",  @first_item.name
    assert_equal "1200",                    @first_item.unit_price
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

  def test_it_can_find_all
    assert_equal 1367, @repo.all.count
  end

  def test_it_can_find_by_id
    # well, it works
    assert_equal 263395617, @repo.find_by_id("263395617").first.id
  end

  def test_it_can_find_all_by_name
    assert_equal [@first_item], @repo.find_all_by_name("510+ RealPush Icon Set")
  end

end
