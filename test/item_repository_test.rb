require 'bigdecimal'
require 'csv'
require_relative 'test_helper'
require_relative '../lib/item_repository'
require_relative '../lib/fileio'

# Test for Item Repository class
class ItemRepositoryTest < Minitest::Test
  def setup
    file_path = FileIO.load('./test/fixtures/test_items.csv')
    @i_repo = ItemRepository.new(file_path)
    @time = Time.now
    @actual_jude = @i_repo.create(
      name: 'St. Jude Action Figure',
      description: 'Worst toy ever.',
      unit_price: 3.00,
      merchant_id: 12334135,
      created_at: '2009-12-09 12:08:04 UTC',
      updated_at: '2010-12-09 12:08:04 UTC'
    )
  end

  def test_item_repository_exists
    assert_instance_of ItemRepository, @i_repo
  end

  def test_creating_an_index_of_items_from_data
    assert_instance_of Hash, @i_repo.items
    assert_instance_of Item, @i_repo.items[263567292]
    assert_instance_of Item, @i_repo.items[263567376]
    assert_instance_of Item, @i_repo.items[263567474]
  end

  def test_all_returns_an_array_of_all_item_instances
    assert_instance_of Array, @i_repo.all
  end

  def test_all_returns_correct_names
    all_items = @i_repo.all
    actual_all_names = all_items.map(&:name)
    expected = ['Intricate Sunset',
                'The Gold Coast, Chicago, Illinois',
                'Minty Green Knit Crochet Infinity Scarf',
                'St. Jude Action Figure']
    assert_equal expected, actual_all_names
  end

  def test_can_find_by_id
    actual_intri_sun = @i_repo.find_by_id(263567292)
    actual_gold_coast = @i_repo.find_by_id(263567376)
    assert_instance_of Item, actual_intri_sun
    assert_instance_of Item, actual_gold_coast
    assert_equal 'Intricate Sunset', actual_intri_sun.name
    assert_equal 'The Gold Coast, Chicago, Illinois', actual_gold_coast.name
  end

  def test_can_find_by_name
    actual_intri_sun = @i_repo.find_by_name('Intricate Sunset')
    actual_gold_coast = @i_repo.find_by_name('The Gold Coast, Chicago, Illinois')
    assert_instance_of Item, actual_intri_sun
    assert_instance_of Item, actual_gold_coast
    assert_equal 263567292, actual_intri_sun.id
    assert_equal 263567376, actual_gold_coast.id
  end

  def test_can_find_name_by_fragment
    actual = @i_repo.find_all_by_name('o')
    result = actual.all? do |item|
      item.class == Item
    end
    assert result
    names = actual.map(&:name)
    assert_equal ['The Gold Coast, Chicago, Illinois',
                  'Minty Green Knit Crochet Infinity Scarf',
                  'St. Jude Action Figure'], names
  end

  def test_can_find_items_by_description
    actual = @i_repo.find_all_with_description('acrylic')
    result = actual.all? do |item|
      item.class == Item
    end
    assert result
    names = actual.map(&:name)
    assert_equal ['Intricate Sunset',
                  'Minty Green Knit Crochet Infinity Scarf'], names
  end

  def test_can_find_all_by_price
    @i_repo.create(
      name: '25 Dollars',
      description: 'Worst toy ever.',
      unit_price: 2500,
      merchant_id: 12334135,
      created_at: '2009-12-09 12:08:04 UTC',
      updated_at: '2010-12-09 12:08:04 UTC'
    )
    actual = @i_repo.find_all_by_price(BigDecimal.new(25))
    result = actual.all? do |item|
      item.class == Item
    end
    assert result
    names = actual.map(&:name)
    assert_equal ['St. Jude Action Figure'], names
  end

  def test_can_get_one_item_at_25_dollars
    actual = @i_repo.find_all_by_price(3.00)
    result = actual.all? do |item|
      item.class == Item
    end
    assert result
    names = actual.map(&:name)
    assert_equal ['St. Jude Action Figure'], names
  end

  def test_can_find_all_by_price_in_range
    actual = @i_repo.find_all_by_price_in_range(2..4)
    result = actual.all? do |item|
      item.class == Item
    end
    assert result
    names = actual.map(&:name)
    assert_equal ['St. Jude Action Figure'], names
  end

  def test_can_find_all_by_merchant_id
    actual = @i_repo.find_all_by_merchant_id(12334135)
    result = actual.all? do |item|
      item.class == Item
    end
    assert result
    names = actual.map(&:name)
    assert_equal ['St. Jude Action Figure'], names
  end

  def test_it_can_generate_next_item_id
    expected = 263567476
    actual = @i_repo.create_new_id
    assert_equal expected, actual
  end

  def test_can_create_new_item
    assert_instance_of Item, @actual_jude
    assert_equal 4, @i_repo.items.count
    assert_equal 'St. Jude Action Figure', @i_repo.items[263567475].name
    assert_equal 'Worst toy ever.', @i_repo.items[263567475].description
    assert_equal 3.00, @i_repo.items[263567475].unit_price
    assert_equal 12334135, @i_repo.items[263567475].merchant_id
    assert_equal '2009-12-09 12:08:04 UTC', @i_repo.items[263567475].created_at
    assert_equal '2010-12-09 12:08:04 UTC', @i_repo.items[263567475].updated_at
  end

  def test_item_can_be_updated
    @i_repo.update(263567475, name: 'Roly Poly Coley',
                              description: 'Best toy ever.',
                              unit_price: 15.00,
                              merchant_id: 12334135,
                              created_at: '2009-12-09 12:08:04 UTC',
                              updated_at: @time)
    assert_equal 'Roly Poly Coley', @i_repo.items[263567475].name
  end

  def test_item_can_be_deleted
    @i_repo.delete(263567475)
    assert_equal 3, @i_repo.items.count
    assert_equal nil, @i_repo.items[263567475]
  end
end
