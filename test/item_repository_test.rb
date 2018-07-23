require_relative '../lib/item_repository'
require_relative '../lib/item'
require_relative './test_helper'

class ItemRepositoryTest < Minitest::Test
  def setup
    @items =
      [{id: 1,
      name: 'OneThing',
      description:'a thing that does stuff',
      unit_price: 1500,
      merchant_id: 1,
      created_at: '2018-07-22',
      updated_at: '2018-07-22'},
      {id: 2,
      name: 'TwoThing',
      description:'a thing that does stuff',
      unit_price: 1300,
      merchant_id: 1,
      created_at: '2018-07-22',
      updated_at: '2018-07-22'},
      {id: 3,
      name: 'ThreeThing',
      description:'a thing that does stuff',
      unit_price: 1500,
      merchant_id: 2,
      created_at: '2018-01-22',
      updated_at: '2018-07-22'},
      {id: 4,
      name: 'FourThing',
      description:'a thing that does stuff',
      unit_price: 1300,
      merchant_id: 2,
      created_at: '2018-03-22',
      updated_at: '2018-07-27'},
      {id: 5,
      name: 'FiveThing',
      description:'a thing that does stuff',
      unit_price: 1500,
      merchant_id: 2,
      created_at: '2018-02-23',
      updated_at: '2018-06-22'},
      {id: 6,
      name: 'SixThing',
      description:'a thing that does stuff',
      unit_price: 12400,
      merchant_id: 3,
      created_at: '2018-04-22',
      updated_at: '2018-07-12'}]

    @item_repository = ItemRepository.new(@items)
  end

  def test_it_exists
    assert_instance_of ItemRepository, @item_repository
  end
end
