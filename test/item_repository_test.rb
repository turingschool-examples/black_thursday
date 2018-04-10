require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require 'bigdecimal'
require 'simplecov'
SimpleCov.start
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  def setup
    @icons = [
      "id: 263395237",
      "name: RealPush Icon Set",
      "description: It writes things.",
      "unit_price: 1200",
      "merchant_id: 12334141",
      "created_at: 2016-01-11 09:34:06 UTC",
      "updated_at: 2007-06-04 21:35:10 UTC"
    ]
    @glitter_frames = [
      "id: 263395617",
      "name: Glitter Scrabble Frames",
      "description: Any colour glitter.",
      "unit_price: 1300",
      "merchant_id: 12334185",
      "created_at: 2016-01-11 11:51:37 UTC",
      "updated_at: 1993-09-29 11:56:40 UTC"
    ]
    @wooden_letters = [
      "id: 263396013",
      "name: Free Standing Wooden Letters",
      "description: Free standing wooden letters, 15cm, any colour.",
      "unit_price: 700",
      "merchant_id: 12334105",
      "created_at: 2016-01-11 11:51:36 UTC",
      "updated_at: 2001-09-17 15:28:43 UTC"
    ]
      @items = [@icons, @glitter_frames, @wooden_letters]
    end

  def test_it_exists
    ir = ItemRepository.new(@items)

    assert_instance_of ItemRepository, ir
  end

  def test_repo_holds_items
    ir = ItemRepository.new(@items)

    ir.items.all? do |item|
      assert_instance_of Item, item
    end
  end

  def test_can_find_all
    ir = ItemRepository.new(@items)

    ir.all.all? do |item|
      assert_instance_of Item, item
    end
  end

  def test_can_find_by_id
    ir = ItemRepository.new(@items)

    assert_equal 263395237, ir.find_by_id(263395237).id
    assert_equal "RealPush Icon Set", ir.find_by_id(263395237).name
    assert_equal "It writes things.", ir.find_by_id(263395237).description
    assert_equal 263395617, ir.find_by_id(263395617).id
    assert_instance_of Time, ir.find_by_id(263395617).created_at
    assert_equal 12334105, ir.find_by_id(263396013).merchant_id
    assert_nil ir.find_by_id(444444444)
  end

  def test_can_find_by_name
    ir = ItemRepository.new(@items)

    assert_equal "RealPush Icon Set", ir.find_by_name("RealPush Icon Set").name
    assert_instance_of Time, ir.find_by_name("Glitter Scrabble Frames").created_at
    assert_equal "Free standing wooden letters, 15cm, any colour.", ir.find_by_name("Free Standing Wooden Letters").description
    assert_nil ir.find_by_name("My Little Pony")
  end

  def test_can_find_all_with_description
    ir = ItemRepository.new(@items)

    assert_instance_of Array, ir.find_all_with_description("tt")
    assert_equal [], ir.find_all_with_description("akira")
    assert_instance_of Item, ir.find_all_with_description("wri")[0]
    assert_equal "RealPush Icon Set", ir.find_all_with_description("wri")[0].name
    assert_equal 12334185, ir.find_all_with_description("olour")[0].merchant_id
    assert_equal 12334105, ir.find_all_with_description("olour")[1].merchant_id
  end

  def test_can_find_by_price
    ir = ItemRepository.new(@items)

    assert_equal "Free Standing Wooden Letters", ir.find_all_by_price(7.0)[0].name
    assert_equal "Any colour glitter.", ir.find_all_by_price(13.0)[0].description
  end

  def test_can_find_all_by_price_in_range
    ir = ItemRepository.new(@items)

    assert_instance_of Item, ir.find_all_by_price_in_range(12.0..13.0)[0]
  end

  def test_item_can_be_found_with_merchant_id
    ir = ItemRepository.new(@items)
    assert_equal "Glitter Scrabble Frames", ir.find_all_by_merchant_id(12334185)[0].name
    assert_equal "Any colour glitter.", ir.find_all_by_merchant_id(12334185)[0].description
    assert_equal 263395617, ir.find_all_by_merchant_id(12334185)[0].id
    assert_equal [], ir.find_all_by_merchant_id(33333333)
  end

  def test_item_can_be_created
    skip
    ir = ItemRepository.new(@items)
    assert_instance_of @items, ir.all

    ir.create({
      # id: 263395238,
      name: "Bootees",
      description: "Gorgeous hand knitted baby bootees.",
      unit_price: BigDecimal.new(12.00, 4),
      merchant_id: 12334271,
      created_at: Time.now,
      updated_at: Time.now
    })
    assert_equal @items.find_by_id(263395238).name, "Bootees"
  end

  def test_find_highest_id
      ir = ItemRepository.new(@items)
      assert_equal 263396013, ir.find_highest_id
  end


  def test_item_can_be_updated
    skip
    ir = ItemRepository.new(@items)
    assert_instance_of @items, ir.all
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
    skip
    ir = ItemRepository.new(@items)
    assert_instance_of @items, ir.all
    assert_equal ir.find_by_id(263395237), @icons
    ir.delete(263395237)
    assert_equal 2, @items.count
  end

end
