require 'bigdecimal'
require 'csv'
require_relative 'test_helper'
require_relative '../lib/repositories/item_repository'
require_relative '../lib/file_io'

# Test for Item Repository class
class ItemRepositoryTest < Minitest::Test
  def setup
    csv = parse_data(items)
    @i_repo = ItemRepository.new(csv)
    @time = Time.now
    @item263567292 = @i_repo.items[263567292]
    @item263567376 = @i_repo.items[263567376]
    @item263567474 = @i_repo.items[263567474]
  end

  def test_item_repository_exists
    assert_instance_of ItemRepository, @i_repo
  end

  def test_creating_an_index_of_items_from_data
    expected = { 263567292 => @item263567292,
                 263567376 => @item263567376,
                 263567474 => @item263567474 }
    assert_equal expected, @i_repo.items
  end

  def test_all_returns_an_array_of_all_item_instances
    assert_equal [@item263567292,
                  @item263567376,
                  @item263567474], @i_repo.all
  end

  def test_can_find_by_id
    actual_one = @i_repo.find_by_id(263567292)
    actual_two = @i_repo.find_by_id(263567376)
    assert_equal @item263567292, actual_one
    assert_equal @item263567376, actual_two
  end

  def test_can_find_by_name
    actual_one = @i_repo.find_by_name('Intricate Sunset')
    actual_two = @i_repo.find_by_name('The Gold Coast, Chicago, Illinois')
    assert_equal @item263567292, actual_one
    assert_equal @item263567376, actual_two
  end

  def test_can_find_name_by_fragment
    actual = @i_repo.find_all_by_name('o')
    assert_equal [@item263567376, @item263567474], actual
  end

  def test_can_find_items_by_description
    actual = @i_repo.find_all_with_description('acrylic')
    assert_equal [@item263567292, @item263567474], actual
  end

  def test_can_find_all_by_price
    item263567474 = @i_repo.create(name: '25 Dollars',
                                   description: 'Worst toy ever.',
                                   unit_price: 2500, merchant_id: 12334135,
                                   created_at: '2009-12-09 12:08:04 UTC',
                                   updated_at: '2010-12-09 12:08:04 UTC')
    actual = @i_repo.find_all_by_price(BigDecimal(25))
    assert_equal [item263567474], actual
  end

  def test_can_find_all_by_price_in_range
    actual = @i_repo.find_all_by_price_in_range(30..70)
    assert_equal [@item263567292, @item263567474], actual
  end

  def test_can_find_all_by_merchant_id
    actual = @i_repo.find_all_by_merchant_id(12336050)
    assert_equal [@item263567292], actual
  end

  def test_it_can_generate_next_item_id
    expected = 263567475
    actual = @i_repo.create_new_id
    assert_equal expected, actual
  end

  def test_can_create_new_item
    a_new_item = new_item
    assert_equal a_new_item, @i_repo.items[263567475]
    assert_equal 4, @i_repo.items.count
  end

  def test_item_can_be_updated
    @i_repo.update(263567474, name: 'Roly Poly Coley',
                              description: 'Best toy ever.',
                              unit_price: 15.00,
                              merchant_id: 12334135,
                              created_at: '2009-12-09 12:08:04 UTC',
                              updated_at: '2010-12-09 12:08:04 UTC')
    assert_equal 'Roly Poly Coley', @i_repo.items[263567474].name
    assert_equal 'Best toy ever.', @i_repo.items[263567474].description
    assert_equal 15.00, @i_repo.items[263567474].unit_price
    assert_equal 12334871, @i_repo.items[263567474].merchant_id
    assert_equal Time.parse('2016-01-11 20:59:20 UTC'), @i_repo.items[263567474].created_at
    assert_equal @time.to_s, @i_repo.items[263567474].updated_at.to_s
  end

  def test_item_can_be_deleted
    @i_repo.delete(263567475)
    assert_equal 3, @i_repo.items.count
    assert_nil @i_repo.items[263567475]
  end

  def test_magic_spec_harness_method_works
    expected = '#<ItemRepository 3 rows>'
    assert_equal expected, @i_repo.inspect
  end

  def new_item
    @i_repo.create(name: 'St. Jude Action Figure',
                   description: 'Worst toy ever.',
                   unit_price: 300, merchant_id: 12334135,
                   created_at: '2009-12-09 12:08:04 UTC',
                   updated_at: '2010-12-09 12:08:04 UTC')
  end

  def items
    %(id,name,description,unit_price,merchant_id,created_at,updated_at
     263567292,Intricate Sunset,"acrylic paint",6100,12336050,2016-01-11 20:57:28 UTC,2006-09-08 18:17:01 UTC
     263567376,"The Gold Coast, Chicago, Illinois","Description2",25000,12336622,2016-01-11 20:57:57 UTC,2011-12-20 13:29:36 UTC
     263567474,Minty Green Knit Crochet Infinity Scarf,"acrylic yarn",3800,12334871,2016-01-11 20:59:20 UTC,2009-12-09 12:08:04 UTC)
  end

  def parse_data(data)
    CSV.parse(data, headers: :true, header_converters: :symbol)
  end
end
