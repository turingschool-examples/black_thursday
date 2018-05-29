require_relative 'test_helper.rb'
require_relative '../lib/sales_engine.rb'
require_relative '../lib/merchantrepository'
require_relative '../lib/merchant'
require_relative '../lib/item_repository.rb'
require_relative '../lib/item'
require 'bigdecimal'

require 'csv'
class ItemTest < Minitest::Test
  def test_it_exists
    i = Item.new({
      :id          => '12336623',
      :name        => 'Pencil',
      :description => 'You can use it to write things',
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now
                })
    assert_instance_of Item, i
  end

  def test_id_to_integer
    i = Item.new({
      :id          => '12336623',
      :name        => 'Pencil',
      :description => 'You can use it to write things',
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now
                })
    assert_equal 12336623, i.id
  end

  def test_name
    i = Item.new({
      :id          => '12336623',
      :name        =>'Pencil',
      :description => 'You can use it to write things',
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now
                })
    assert_equal 'Pencil', i.name
  end

  def test_description
    i = Item.new({
      :id          => '12336623',
      :name        => 'Pencil',
      :description => 'You can use it to write things',
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now
                })
    assert_equal 'You can use it to write things', i.description
  end

  def test_unit_price
    i = Item.new({
      :id          => '12336623',
      :name        => 'Pencil',
      :description => 'You can use it to write things',
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now
                })
    assert_equal 10.99, i.unit_price
  end

  def test_time
    i = Item.new({
      :id          => '12336623',
      :name        => 'Pencil',
      :description => 'You can use it to write things',
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now
                })
    assert_instance_of Time, i.created_at
    assert_instance_of Time, i.updated_at
  end

  def test_merchant_id
    i = Item.new({
      :id          => '12336623',
      :name        => 'Pencil',
      :description => 'You can use it to write things',
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => '263396209'
                })
    assert_equal 263396209, i.merchant_id
  end

  def test_unit_price_to_dollars
    i = Item.new({
      :id          => '12336623',
      :name        => 'Pencil',
      :description => 'You can use it to write things',
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => '263396209'
                })
  assert_equal 10.99, i.unit_price_to_dollars
  end








end
