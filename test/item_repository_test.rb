require 'test_helper'
require './lib/item_repository'
require './lib/item'

class ItemRepositoryTest < Minitest::Test
  def setup
    @ir = ItemRepository.new
    @ir.create({
    :id          => 1,
    :name        => "Pencil",
    :description => "You can use it to write things",
    :unit_price  => BigDecimal.new(10.99,4),
    :created_at  => Time.now,
    :updated_at  => Time.now,
    :merchant_id => 2
    })
  end
  def test_it_exists

    assert_instance_of ItemRepository, @ir
  end

  def test_all_returns_array_of_instances

     assert_instance_of Array, @ir.all
  end

  def test_find_by_ID

    assert_equal "Pencil", @ir.find_by_ID(1).name
  end

  def test_find_by_name

    assert_equal 1, @ir.find_by_name("Pencil").id
  end

  def test_find_all_with_description

    assert_equal 1, @ir.find_all_with_description("You can use it to write things").first.id
  end

  def find_all_by_price

    assert_equal 1, @ir.find_all_by_price(BigDecimal.new(10.99,4)).first.id
  end

  def find_all_by_price_in_range

    assert_equal 1, @ir.find_all_by_price_in_range(1..11).first.id
  end

  def find_all_by_merchant_id

    assert_equal 1, @ir.find_all_by_merchant_id(2).first.id
  end

  def test_create
    @ir.create({
  :id          => 100,
  :name        => "Asa",
  :description => "My name",
  :unit_price  => BigDecimal.new(25.00, 4),
  :created_at  => Time.now,
  :updated_at  => Time.now,
  :merchant_id => 19
})
    assert @ir.all.map(&:id).include?(100)
  end

  def test_update

    assert_equal @ir.all.map(&:name).include?("Pen"), @ir.update(1, {
  :name        => "Pen",
  :description => "You can use it to write things",
  :unit_price  => BigDecimal.new(10.99,4),
  :created_at  => Time.now,
  :updated_at  => Time.now,
  :merchant_id => 11
})
  end

  def test_delete
     @ir.delete(5)

    refute @ir.all.map(&:id).include?(5)
  end
end
