require_relative 'test_helper.rb'
require_relative '../lib/sales_engine.rb'
require_relative '../lib/merchantrepository'
require_relative '../lib/merchant'
require_relative '../lib/item_repository.rb'

require 'csv'
class ItemRepositoryTest < Minitest::Test
  def test_it_exists
    ir = ItemRepository.new
    assert_instance_of ItemRepository, ir
  end

  def test_all
    ir = ItemRepository.new
    assert_equal [], ir.all
  end

  def test_find_by_id
    ir = ItemRepository.new
    assert_nil ir.find_by_id('263395237')
  end

  def test_find_by_name
    ir = ItemRepository.new
    assert_equal nil, ir.find_by_name('510+ RealPush Icon Set')
  end

  def find_all_with_description
    ir = ItemRepository.new
    assert_equal [], ir.find_all_with_descriptions('a BONUS PACK')
  end

  def find_all_by_price
    engine = SalesEngine.new
    price = BigDecimal.new(25)
    expected = engine.items.find_all_by_price(price)
    assert_equal 79, expected.length
  end

  def find_all_by_price_in_range
    ir = ItemRepository.new
    assert_equal [], ir.find_all_by_price_in_range(0..9999)
  end

  def test_find_all_by_merchant_id
    ir = ItemRepository.new
    assert_equal [], ir.find_all_by_merchant_id('12334141')
  end

  def test_create
    engine = SalesEngine.new
    engine.items.create(attributes)
    expected = engine.items.find_by_id(263567475)
    expected.name = engine.items.find_by_name('Capita Defenders of Awesome 2018')
    assert_equal 'Capita Defenders of Awesome 2018', expected.name
    assert_equal [], item.create
  end

  def test_update
    ir = ItemRepository.new
    original_item = ir.create({name: 'Teddy Bear', description: 'fluffy', unit_price: 10})
    updated_item = ir.update('12336623',{name: 'Pokemon', description: 'powerful', unit_price: 15})
    assert_equal 'Pokemon',updated_item.name
    assert_equal 'powerful', updated_item.description
    assert_equal '15', updated_item.unit_price
  end

  def test_delete_merchant
    ir = ItemRepository.new
    assert ir.find_by_id('12336622')
    ir.delete('12336622')
    refute ir.find_by_id('12336622')
  end

end
