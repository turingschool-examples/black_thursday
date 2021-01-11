require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require './lib/item_repository'
require './lib/sales_engine'
class ItemRepositoryTest < Minitest::Test
  def setup
    @merchant_path = './data/merchants.csv'
    @item_path = './data/items.csv'
    @invoice_path = './data/invoices.csv'
    @locations = { items: @item_path,
                  merchants: @merchant_path,
                  invoices: @invoice_path}
    @engine = SalesEngine.new(@locations)
    @ir = ItemRepository.new('./data/items.csv', @engine)
    @i = Item.new({
                   id: 263_550_472,
                   name: 'Pencil',
                   description: 'A large Yeti of sorts, casually devours a cow as the others watch numbly.',
                   unit_price: BigDecimal(10.99, 4),
                   created_at: Time.now.to_s,
                   updated_at: Time.now.to_s,
                   merchant_id: 2
                 }, @ir)
  end

  def test_it_exists_and_has_attributes
    assert_instance_of ItemRepository, @ir
    assert_equal './data/items.csv', @ir.path
    assert_instance_of SalesEngine, @ir.engine
  end

  def test_it_read_items
    assert_equal 1367, @ir.items.count
  end

  def test_returns_all
    assert_equal 1367, @ir.all.count
  end

  def test_find_by_id_returns_an_instance_of_item
    assert_instance_of Item, @ir.find_by_id(263_399_037)
    assert_equal 'Green Footed Ceramic Bowl', @ir.find_by_id(263_399_037).name
  end

  def test_find_by_name
    assert_equal 263_553_176, @ir.find_by_name('Pink Depression Grill Plate Miss America Pattern').id
    assert_nil @ir.find_by_name('abc')
  end

  def test_find_all_with_description
    assert_equal 1, @ir.find_all_with_description('A large Yeti of sorts, casually devours a cow as the others watch numbly.').count
    assert_equal [], @ir.find_all_with_description('akjhaskjdh223k1jh2hash')
  end

  def test_find_all_by_price
    assert_equal 79, @ir.find_all_by_price(25).length
    assert_equal [], @ir.find_all_by_price(BigDecimal(1_000_000))
  end

  def test_find_all_by_price_range
    assert_equal 19, @ir.find_all_by_price_in_range(1_000..1_500).length
    assert_equal 949, @ir.find_all_by_price_in_range(5..80).length
  end

  def test_find_merchant_id_returns_item_objects
    assert_equal 263_395_237, @ir.find_all_by_merchant_id(12_334_141)[0].id
    assert_equal [], @ir.find_all_by_merchant_id(345_329)
  end

  def test_create_attributes_us_to_add_items
    assert_equal 263_567_474, @ir.items.last.id
    @ir.create({
                id: 1326,
                name: 'Pencil',
                description: 'A large Yeti of sorts, casually devours a cow as the others watch numbly.',
                unit_price: BigDecimal(10.99, 4),
                created_at: Time.now,
                updated_at: Time.now,
                merchant_id: 2
              }, @ir = @ir)
    assert_instance_of Item, @ir.find_by_name('Pencil')
    assert_equal 263_567_475, @ir.find_by_name('Pencil').id
  end

  def test_update_attributes_can_change_item_objects
    @ir.create({
                id: 1326,
                name: 'Pencil',
                description: 'A large Yeti of sorts, casually devours a cow as the others watch numbly.',
                unit_price: BigDecimal(10.99, 4),
                created_at: Time.now,
                updated_at: Time.now,
                merchant_id: 2
              }, @ir = @ir)
    @ir.update(263_567_475, {
                id: 263_567_475,
                name: 'New Item',
                description: 'A large Yeti of sorts, casually devours a cow as the others watch numbly.',
                unit_price: BigDecimal(10.99, 4),
                created_at: Time.now,
                updated_at: Time.now,
                merchant_id: 2
              })
    assert_equal 'New Item', @ir.find_by_id(263_567_475).name
  end

  def test_item_is_deleted
    assert_equal 263_399_037, @ir.find_by_name('Green Footed Ceramic Bowl').id
    @ir.delete(263_399_037)
    assert_nil @ir.find_by_name('Green Footed Ceramic Bowl')
  end

  def test_merchant_item_count
    assert_instance_of Hash, @ir.merchant_item_count
    assert_equal 475, @ir.merchant_item_count.length
  end

  def test_average_item_price
    assert_equal 251.06, @ir.average_item_price
  end

  def test_merchant_id_list
    assert_instance_of Array, @ir.merchant_id_list
    assert_equal 475, @ir.merchant_id_list.length
  end

  def test_items_sum
    assert_equal 343192.33, @ir.items_sum
  end

  def test_total_items
    assert_equal 1367, @ir.total_items
  end
end
