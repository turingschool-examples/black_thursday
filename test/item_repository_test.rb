require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require 'bigdecimal'
require 'simplecov'
simpcov.start
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  def setup
    @icons = Item.new({
      id: 263395237,
      name: "RealPush Icon Set",
      description: "It writes things.",
      unit_price: BigDecimal.new(12.00, 4),
      merchant_id: 12334141,
      created_at: Time.now,
      updated_at: Time.now
      })
    @glitter_frames = Item.new({
      id: 263395617,
      name: "Glitter Scrabble Frames",
      description: "Any colour glitter.",
      unit_price: BigDecimal.new(13.00, 4)
      created_at: Time.now,
      updated_at: Time.now
      })
    @wooden_letters = Item.new({
      id: 263396013,
      name: "Free Standing Wooden Letters",
      description: "Free standing wooden letters, 15cm, any color.",
      unit_price: BigDecimal.new(7.00, 3),
      merchant_id: 12334105,
      created_at: Time.now,
      updated_at: Time.now
      })
      @items = [@icons, @glitter_frames, @wooden_letters]
    end

  def test_it_exists
    ir = ItemRepository.new(@items)

    assert_instance_of ItemRepository, ir
  end

  def test_repo_holds_items
    ir = ItemRepository.new(@items)
    assert ir.class? Array

    ir.all? do |item|
      assert_instance_of Item, item
    end
    assert_equal @items, ir.all
  end

  def test_converts_price_to_dollars
    ir = ItemRepository.new(@items)
    @items.map do |item|
      '%.2f' % item[:unit_price][0]
    end
    assert_equal [12.00, 13.00, 7.00], @items.convert_to_dollars
  end

  def test_can_find_by_id
    ir = ItemRepository.new(@items)

    assert_equal @icons, ir.find_by_id(263395237)
    assert_equal @glitter_frames, ir.find_by_id(12334185)
    assert_equal @wooden_letters, ir.find_by_id(12334105)
    assert_equal nil, ir.find_by_id(444444444)
  end

  def test_can_find_by_name
    ir = ItemRepository.new(@items)

    assert_equal @icons, ir.find_by_name("RealPush Icon Set")
    assert_equal @glitter_frames, ir.find_by_name("Any colour glitter.")
    assert_equal @wooden_letters, ir.find_by_name("Free Standing Wooden Letters")
    assert_equal nil, ir.find_by_name("My Little Pony")
  end

  def test_can_find_by_description
    ir = ItemRepository.new(@items)

    assert_equal [@glitter_frames, @wooden_letters], ir.find_all_by_name("tt")
    assert_equal [@icons], ir.find_all_by_name("ico")
    assert_equal [], ir.find_all_by_name("akira")
  end

  def test_can_find_by_price
    ir = ItemRepository.new(@items)

    assert_equal [@icons], ir.find_all_by_price(9)
  end

  def test_item_can_be_found_with_merchant_id
    ir = ItemRepository.new(@items)


  end

  def test_item_can_be_created
    ir = ItemRepository.new(@items)
    assert_instance_of @items = ir.all

    ir.create Item.new({
      id: 263395238,
      name: "Bootees",
      description: "Gorgeous hand knitted baby bootees.",
      unit_price: BigDecimal.new(12.00, 4),
      merchant_id: 12334271,
      created_at: Time.now,
      updated_at: Time.now
    })
    assert_equal @items.find_by_id(263395238).name, "Bootees"
  end

  def test_item_can_be_updated
    ir = ItemRepository.new(@items)
    assert_instance_of @items = ir.all
    assert_equal @icons, @items.find_by_id(263395237)
    ir.update ({
      id: 263395237,
      name: "RealPush Icon Set",
      description: "It writes things.",
      unit_price: BigDecimal.new(12.00, 4),
      merchant_id: 12334141,
      created_at: Time.now,
      updated_at: Time.now
      })
  end

  def test_it_can_be_deleted
    ir = ItemRepository.new(@items)
    assert_instance_of @items = ir.all
    assert_equal ir.find_by_id(263395237), @icons
    ir.delete(263395237)
    assert_equal 2, @items.size
  end




end
