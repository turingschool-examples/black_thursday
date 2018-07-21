require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'
require 'pry'
require './lib/item'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  def setup
    @ir = ItemRepository.new
    @item1 = @ir.create({
      :id           => 1,
      :name         => "Pencil",
      :description  => "You can use it to write things",
      :unit_price   => BigDecimal.new(10.99,4),
      :created_at   => Time.now,
      :updated_at   => Time.now,
      :merchant_id  => 4
      })
    @item2 = @ir.create({
      :id           =>  2,
      :name         => "Book",
      :description  => "You can use it to learn things",
      :unit_price   => BigDecimal.new(34,4),
      :created_at   => Time.now,
      :updated_at   => Time.now,
      :merchant_id  => 5
      })
    @item3 = @ir.create({
      :id           =>  3,
      :name         => "Pencil Sharpener",
      :description  => "You can use it to sharpen pencils",
      :unit_price   => BigDecimal.new(13.99,4),
      :created_at   => Time.now,
      :updated_at   => Time.now,
      :merchant_id  => 6
      })
  end

  def test_it_exists
    assert_instance_of ItemRepository, @ir
  end

  def test_it_creates_new_item_instance
    assert_instance_of Item, @item1
  end

  def test_it_returns_array_of_all_item_instances
    assert_equal [@item1, @item2, @item3], @ir.all
  end




end
