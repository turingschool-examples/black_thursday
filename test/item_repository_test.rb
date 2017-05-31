require 'pry'

require 'simplecov'
SimpleCov.start
require 'bigdecimal'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item_repository'
require_relative '../lib/item'

class ItemRepositoryTest < MiniTest::Test

  def test_if_create_class
    ir = ItemRepository.new

    assert_instance_of ItemRepository, ir
  end

  def test_initialize
    ir = ItemRepository.new

    assert_equal [], ir.all
  end

  # def test_if_all_works
  #   ir = ItemRepository.new
  #   i1 = Item.new({:name        => "Pencil",
  #                 :description => "You can use it to write things",
  #                 :unit_price  => BigDecimal.new(10.99,4),
  #                 :created_at  => Time.now,
  #                 :updated_at  => Time.now
  #                }, 1)
  #
  #   i2 = Item.new({:name        => "Pen",
  #                 :description => "You can use it to write things",
  #                 :unit_price  => BigDecimal.new(11.99,4),
  #                 :created_at  => Time.now,
  #                 :updated_at  => Time.now
  #                }, 2)
  #
  #
  # end



end
