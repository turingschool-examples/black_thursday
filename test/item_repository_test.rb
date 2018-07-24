require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item_repository.rb'
require_relative '../lib/item.rb'
require_relative '../lib/sales_engine.rb'
require_relative '../lib/merchant.rb'
require_relative '../lib/merchant_repository.rb'

class ItemRepositoryTest < Minitest::Test
  def setup
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
      })
      @items_placeholder =
      [{id: 1,
      name: 'Thing1',
      description:'a locket',
      unit_price: 1200,
      merchant_id: 1,
      created_at: '2018-07-23',
      updated_at: '2018-07-23'},
      {id: 2,
      name: 'Thing2',
      description:'a painting of a dog',
      unit_price: 1300,
      merchant_id: 1,
      created_at: '2018-07-23',
      updated_at: '2018-07-23'},
      {id: 3,
      name: 'Thing3',
      description:'a candle that smells like lucky charms',
      unit_price: 1400,
      merchant_id: 2,
      created_at: '2018-01-23',
      updated_at: '2018-07-23'}]
  end

  def test_it_exists
    #items_file = ['painting','candles','locket']
    ir = ItemRepository.new(@items_placeholder)
    assert_instance_of ItemRepository, ir
  end

  def test_it_creates_items
    skip
  #  items_file = ['painting','candles','locket']
    ir = ItemRepository.new(@items_placeholder)

  end

  def test_all_array
  #  items_file = ['painting','candles','locket']
    ir = ItemRepository.new(@items_placeholder)
    assert_equal [ ], ir.all
  end

  def test_can_find_by_id
    ir = ItemRepository.new(@items_placeholder)
    assert_equal 3 , ir.find_by_id(3)
  end
end
