require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repository'
require './lib/file_loader'
require './test/test_helper'
require 'pry'


class ItemRepositoryTest < MiniTest::Test
  include FileLoader

  def setup
  @mock_data = [{
    :id          => 1,
    :name        => "Pencil",
    :description => "You can use it to write things",
    :unit_price  => BigDecimal.new(10.99,4),
    :created_at  => Time.now,
    :updated_at  => Time.now,
    :merchant_id => 11111},
    {:id         => 2,
    :name        => "stationary set",
    :description => "writing is a lost art!",
    :unit_price  => BigDecimal.new(99.99,4),
    :created_at  => Time.now,
    :updated_at  => Time.now,
    :merchant_id => 22222},
    {:id          => 3,
    :name        => "GlitterPens",
    :description => "Make It Sparkle",
    :unit_price  => BigDecimal.new(5.99,3),
    :created_at  => Time.now,
    :updated_at  => Time.now,
    :merchant_id => 33333},
    {:id          => 4,
    :name        => "Ruby Studded Shades",
    :description => "Life is rosy",
    :unit_price  => BigDecimal.new(101.99,5),
    :created_at  => Time.now,
    :updated_at  => Time.now,
    :merchant_id => 44444}
    ] 

    @irepo = ItemRepository.new(@mock_data)
  end

  def test_existence
    # skip
    assert_instance_of ItemRepository, @irepo
  end

  def test_it_can_return_all_items
    skip
    assert_equal 1367, @irepo.all.count
    assert_instance_of Item, @irepo.all[20]
    assert_instance_of Item, @irepo.all[99]
    assert_instance_of Item, @irepo.all[1366]
  end

  def test_test_it_can_find_item_by_id
    skip
    item = @irepo.find_by_id(263395237)
    assert_equal '510+ RealPush Icon Set', item.name
    assert_equal 263395237, item.id
    assert_equal 12334141, item.merchant_id
    assert_equal Time.parse('2016-01-11 09:34:06 UTC'), item.created_at
  end

  def test_test_it_can_find_item_by_name
    skip
    search_1 = @irepo.find_by_name("Glitter scrabble frames")
    item_1 = @irepo.find_by_id(263395617)

    assert_equal item_1, search_1

    search_2 = @irepo.find_by_name('Wooden pen and stand')
    item_2 = @irepo.find_by_id(263397843)

    assert_equal item_2, search_2
  end

  def test_find_by_description
    skip
    search = @irepo.find_by_name("Glitter scrabble frames")
    assert_equal @irepo.repository[1], @irepo.find_all_with_description("Glitter scrabble frames \n\nAny colour glitter \nAny wording\n\nAvailable colour scrabble tiles\nPink\n
      Blue\nBlack\nWooden")
  end
end
