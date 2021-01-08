require 'simplecov'
SimpleCov.start

require 'time'
require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  def setup
    @sample_data = './test/fixtures/sample_items.csv'
  end

  def test_it_exists
    test = ItemRepository.new(@sample_data, 'engine')

    assert_instance_of ItemRepository, test
  end

  def test_it_has_readable_attributes
    test = ItemRepository.new(@sample_data, 'engine')

    assert_equal test.items[0..3], test.items
  end

  def test_it_can_inspect_an_item
    test = ItemRepository.new(@sample_data, 'engine')

    assert_equal '#<ItemRepository 4 rows>', test.inspect
  end

  def test_it_can_give_all_items
    test = ItemRepository.new(@sample_data, 'engine')

    assert_equal test.items, test.all
  end

  def test_it_can_find_by_id
    test = ItemRepository.new(@sample_data, 'engine')

    assert_nil test.find_by_id(5)
    assert_equal test.items[0], test.find_by_id(1)
  end

  def test_it_can_find_by_name
    test = ItemRepository.new(@sample_data, 'engine')

    assert_nil test.find_by_name('Hello World')
    assert_equal test.items[2], test.find_by_name('Something to do Things')

  end

  def test_it_can_find_all_with_description
    test = ItemRepository.new(@sample_data, 'engine')

    assert_equal [], test.find_all_with_description('fboagbrprgruoan')
    assert_equal test.items[2, 3], test.find_all_with_description('you')
  end

  def test_it_can_find_all_by_price
    test = ItemRepository.new(@sample_data, 'engine')
    price = BigDecimal(3)

    assert_equal [], test.find_all_by_price(100)
    assert_equal test.items[2, 3], test.find_all_by_price(price)
  end

  def test_it_can_find_all_by_price_in_range
    test = ItemRepository.new(@sample_data, 'engine')
    price_range = (3.00..4.00)

    expected = [test.items[0], test.items[2], test.items[3]]

    assert_equal [], test.find_all_by_price_in_range(100..101)
    assert_equal expected, test.find_all_by_price_in_range(price_range)
  end

  def test_it_can_find_all_by_merchant_id
    test = ItemRepository.new(@sample_data, 'engine')

    expected = [test.items[0], test.items[2]]

    assert_equal [], test.find_all_by_merchant_id(7)
    assert_equal expected, test.find_all_by_merchant_id(25)
  end

  def test_max_item_id
    test = ItemRepository.new(@sample_data, 'engine')

    assert_equal 4, test.max_item_id
  end

  def test_it_can_create
    test = ItemRepository.new(@sample_data, 'engine')
    attributes = {
                  name: 'Yet another Thing!',
                  description: 'Get it now! you must have it!',
                  unit_price: BigDecimal(599.99, 5),
                  merchant_id: 25
                  }

    test.create(attributes)

    assert_equal 'Yet another Thing!', test.find_by_id(5).name
    assert_equal 5.99, test.find_by_id(5).unit_price
  end

  def test_it_can_update
    test = ItemRepository.new(@sample_data, 'engine')
    update = {
              name: 'Computer',
              description: 'This is a computer.',
              unit_price: 125
              }

    test.update(1, update)

    assert_equal 'Computer', test.items[0].name
    assert_equal 'This is a computer.', test.items[0].description
    assert_equal 125, test.items[0].unit_price
  end

  def test_it_can_delete
    test = ItemRepository.new(@sample_data, 'engine')

    test.delete(1)

    assert_nil test.find_by_id(1)
  end
end
