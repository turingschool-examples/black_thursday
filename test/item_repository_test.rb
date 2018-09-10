require_relative 'test_helper'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  def setup
    @time_1 = '1993-10-28 11:56:40 UTC'

    @time_2 = '1993-09-29 12:45:30 UTC'

    @raw_data = [{id:          '123',
                  name:        'testname',
                  description: 'fakedescription',
                  merchant_id: '456',
                  unit_price:  '1200',
                  created_at:  @time_1,
                  updated_at:  @time_2},
                 {id:          '321',
                  name:        'secondname',
                  description: 'describedagain',
                  merchant_id: '654',
                  unit_price:  '2100',
                  created_at:  @time_2,
                  updated_at:  @time_1}]

    @repo = ItemRepository.new(@raw_data)
  end

  def test_it_exists
    assert_instance_of(ItemRepository, @repo)
  end

  def test_it_can_display_items
    items = @repo.items
    assert_instance_of(Array, items)
    assert(items.all? {|item| item.class == Item})
    assert_equal(321, items[1].id)
  end

end
