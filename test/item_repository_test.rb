require_relative '../lib/salesengine.rb'
require_relative '../lib/merchantrepository'
require_relative '../lib/merchant'
require_relative '../lib/item_repository.rb'
require 'minitest/autorun'
require 'minitest/pride'
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
    ir = ItemRepository.new
    assert_equal [], ir.find_all_with_price('1200')
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
    ir = ItemRepository.new
    ir.create({name: 'Teddy Bear', description: 'fluffy', unit_price: 10})
  end



end
