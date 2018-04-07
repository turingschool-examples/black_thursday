require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
class ItemTest < Minitest::Test
  def setup
    @data = { id: 1,
              name: 'Pencil',
              description: 'You can use it to write things',
              unit_price: 1200,
              merchant_id: 2,
              created_at: '2016-01-11 11:51:37 UTC',
              updated_at: '2016-01-11 11:51:37 UTC' }
  end

  def test_it_exists
    item = Item.new(@data)

    assert_instance_of Item, item
  end
end
