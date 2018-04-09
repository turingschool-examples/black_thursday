require_relative 'test_helper'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  def setup
    @ir = ItemRepository.new
  end

  def test_it_exists
    @ir = ItemRepository.new
    assert_instance_of ItemRepository, @ir
  end

  def test_it_can_create_items_from_csv
    @ir.from_csv('./data/items.csv')
    # ('./test/fixtures/item_fixtures.csv')
    assert_equal 1367, @ir.elements.count
    assert_instance_of Item, @ir.elements[263395237]
    assert_equal '510+ RealPush Icon Set', @ir.elements[263395237].name
    assert_instance_of Item, @ir.elements[263414049]
    assert_equal 'Snow fallen', @ir.elements[263414049].name
    assert_equal 'Minty Green Knit Crochet Infinity Scarf', @ir.elements[263567474].name

    assert_nil @ir.elements['id']
    assert_nil @ir.elements[999999999]
    assert_nil @ir.elements[0]
    assert_instance_of Time, @ir.elements[263395237].created_at
    assert_instance_of Time, @ir.elements[263414049].updated_at
  end

  def test_all_method
    @ir.from_csv('./data/items.csv')
    all_items = @ir.all
    assert_equal 1367, all_items.count
    assert_instance_of Item, all_items[0]
    assert_instance_of Item, all_items[800]
    assert_instance_of Item, all_items[1366]
    assert_instance_of Array, all_items
  end

  def test_find_by_id
    @ir.from_csv('./data/items.csv')
    item = @ir.find_by_id(263395237)
    assert_instance_of Item, item
    assert_equal '510+ RealPush Icon Set', item.name

    item2 = @ir.find_by_id(263414049)
    assert_instance_of Item, item2
    assert_equal 'Snow fallen', item2.name
    assert_nil @ir.find_by_id(12345678901234567890)
  end

  def test_find_by_name_not_case_sensitive
    @ir.from_csv('./data/items.csv')
    item = @ir.find_by_name('510+ realPush IcOn Set')
    assert_instance_of Item, item
    assert_equal 263395237, item.id

    item2 = @ir.find_by_name('snoW fallen')
    assert_instance_of Item, item2
    assert_equal 263414049, item2.id
    assert_nil @ir.find_by_name('random gibberish')
  end

  def test_find_all_with_description
    @ir.from_csv('./data/items.csv')
    items = @ir.find_all_with_description('will fit newborn')
    assert_instance_of Array, items
    find = @ir.find_by_id(263551162)
    assert items.include?(find)

    items2 = @ir.find_all_with_description('Handmade in Germany')
    assert_instance_of Array, items2
    find = @ir.find_by_id(263396279)
    find2 = @ir.find_by_id(263396463)
    find3 = @ir.find_by_id(263396255)
    # binding.pry

    assert items2.include?(find)
    assert items2.include?(find2)
    refute items2.include?(find3)

    items3 = @ir.find_all_with_description('random gibberish')
    assert_equal [], items3
  end

  def test_find_all_by_price
    @ir.from_csv('./data/items.csv')
    items = @ir.find_all_by_price(3.99)
    assert_instance_of Array, items
    find = @ir.find_by_id(263397163)
    assert items.include?(find)

    items2 = @ir.find_all_by_price(50.00)
    assert_instance_of Array, items2
    find = @ir.find_by_id(263399749)
    find2 = @ir.find_by_id(263399825)
    find3 = @ir.find_by_id(263399933)
    assert items2.include?(find)
    assert items2.include?(find2)
    refute items2.include?(find3)

    items3 = @ir.find_all_by_price(9999999999)
    assert_equal [], items3
  end

  def test_find_all_by_price_in_range
    @ir.from_csv('./data/items.csv')
    items = @ir.find_all_by_price_in_range(3.90..4.00)
    assert_instance_of Array, items
    find = @ir.find_by_id(263397163)
    assert items.include?(find)

    items2 = @ir.find_all_by_price_in_range(47.50..50.10)
    assert_instance_of Array, items2
    find = @ir.find_by_id(263399749)
    find2 = @ir.find_by_id(263399825)
    find3 = @ir.find_by_id(263399187)
    find4 = @ir.find_by_id(263399933)
    assert items2.include?(find)
    assert items2.include?(find2)
    assert items2.include?(find3)
    refute items2.include?(find4)

    items3 = @ir.find_all_by_price_in_range(9999999999..99999999999)
    assert_equal [], items3
  end

  def test_find_all_by_merchant_id
    @ir.from_csv('./data/items.csv')
    items = @ir.find_all_by_merchant_id(12334257)
    assert_instance_of Array, items
    find = @ir.find_by_id(263397843)
    assert items.include?(find)

    items2 = @ir.find_all_by_merchant_id(12334185)
    assert_instance_of Array, items2
    find = @ir.find_by_id(263395617)
    find2 = @ir.find_by_id(263395721)
    find3 = @ir.find_by_id(263397201)
    assert items2.include?(find)
    assert items2.include?(find2)
    refute items2.include?(find3)

    items3 = @ir.find_all_by_merchant_id(9999999999)
    assert_equal [], items3
  end

  def test_it_can_create_a_new_item
    assert_equal 0, @ir.all.count
    time = Time.now
    @ir.create({
                :name        => "Pencil",
                :description => "You can use it to write things",
                :unit_price  => BigDecimal.new(10.99,4),
                :created_at  => time,
                :updated_at  => time,
                :merchant_id => 7
                })
    assert_equal 1, @ir.all.count
    assert_equal 'Pencil', @ir.find_by_id(1).name
    assert_equal time, @ir.find_by_id(1).updated_at

    @ir.create({
                :name        => "Pen",
                :description => "NASA's response to Russian",
                :unit_price  => BigDecimal.new(0.02,4),
                :created_at  => time,
                :updated_at  => time,
                :merchant_id => 8
                })
    assert_equal 2, @ir.all.count
    assert_equal 'Pen', @ir.find_by_id(2).name
  end

  def test_it_can_update_an_existing_item
    assert_equal 0, @ir.all.count
    time = Time.now - 1
    @ir.create({
                :name        => "Pencil",
                :description => "You can use it to write things",
                :unit_price  => BigDecimal.new(10.99,4),
                :created_at  => time,
                :updated_at  => time,
                :merchant_id => 7
                })
    assert_equal 1, @ir.all.count
    assert_equal 'Pencil', @ir.find_by_id(1).name
    assert_equal 7, @ir.find_by_id(1).merchant_id

    @ir.update(1, {
                    :name        => "Pen",
                    :description => "NASA's response to Russian",
                    :unit_price  => BigDecimal.new(0.02,4),
                    :created_at  => time,
                    :updated_at  => time,
                    :merchant_id => 8
                    })
    assert_equal 1, @ir.all.count
    assert_equal 'Pen', @ir.find_by_id(1).name
    assert_equal "NASA's response to Russian", @ir.find_by_id(1).description
    assert_equal 7, @ir.find_by_id(1).merchant_id
    assert time < @ir.find_by_id(1).updated_at
  end

  def test_it_can_delete_an_existing_item
    assert_equal 0, @ir.all.count
    time = Time.now
    @ir.create({
                :name        => "Pencil",
                :description => "You can use it to write things",
                :unit_price  => BigDecimal.new(10.99,4),
                :created_at  => time,
                :updated_at  => time,
                :merchant_id => 7
                })
    assert_equal 1, @ir.all.count
    assert_equal 'Pencil', @ir.find_by_id(1).name

    @ir.delete(1)
    assert_equal 0, @ir.all.count
  end
end
