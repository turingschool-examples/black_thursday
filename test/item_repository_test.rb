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
    # skip
    assert_equal 4, @irepo.all.count
    assert_equal "stationary set", @irepo.all[1].name
    assert_equal "Ruby Studded Shades", @irepo.all[3].name
  end

  def test_test_it_can_find_item_by_id
    # skip
    assert_equal @irepo.all[0], @irepo.find_by_id(1)
    assert_equal @irepo.all[3], @irepo.find_by_id(4)
  end

  def test_test_it_can_find_item_by_name
    # skip
    assert_equal @irepo.all[1], @irepo.find_by_name("stationary set")
    assert_equal @irepo.all[2], @irepo.find_by_name("GlitterPens")
  end

  def test_find_by_description
    # skip
    search = @irepo.find_all_with_description("Make It Sparkle")
    assert_equal [@irepo.all[2]], search
  end

  def test_it_can_find_all_items_by_price
    

  end
end
