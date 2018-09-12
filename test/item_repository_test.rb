require_relative 'test_helper'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  def setup
    @item1 = stub('Item', id: 123)
    @item2 = stub('Item', id: 456)
    @item3 = stub('Item', id: 321)
    @mock_data = [{id: 123},{id: 456},{id: 321}]
    @time1 = '1993-10-28 11:56:40 UTC'
    @time2 = '1993-09-29 12:45:30 UTC'
    @raw_data = [{id:          '123',
                  name:        'testname',
                  description: 'fakedescription',
                  merchant_id: '456',
                  unit_price:  '1200',
                  created_at:  @time1,
                  updated_at:  @time2},
                 {id:          '321',
                  name:        'secondname',
                  description: 'describedagain',
                  merchant_id: '654',
                  unit_price:  '2100',
                  created_at:  @time2,
                  updated_at:  @time1}]
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

  def test_it_can_find_all_with_description
    @item1.stubs(description: 'A Word is here!')
    @item2.stubs(description: 'None here...')
    @item3.stubs(description: 'Another word.')
    Item.stubs(:from_raw_hash).returns(@item1, @item2, @item3)
    repository = ItemRepository.new(@mock_data)
    assert_equal([@item1, @item3], repository.find_all_with_description('word'))
  end

  # TODO: Refactor tests
  def test_it_can_find_all_by_price
    item1 = stub('Item', id: 123, unit_price: BigDecimal.new(12.00, 4))
    item2 = stub('Item', id: 456, unit_price: BigDecimal.new(13.00, 4))
    item3 = stub('Item', id: 321, unit_price: BigDecimal.new(12.00, 4))
    Item.stubs(:from_raw_hash).returns(item1).then.returns(item2).then.returns(item3)
    datas = [{id: 123},{id: 456},{id: 321}]
    repo = ItemRepository.new(datas)
    assert_equal([item1, item3], repo.find_all_by_price(BigDecimal.new(12.00, 4)))
  end

  def test_it_can_find_all_by_price_in_range
    item1 = stub('Item', id: 123, unit_price: BigDecimal.new(12.00, 4))
    item2 = stub('Item', id: 456, unit_price: BigDecimal.new(18.00, 4))
    item3 = stub('Item', id: 321, unit_price: BigDecimal.new(5.00, 4))
    Item.stubs(:from_raw_hash).returns(item1).then.returns(item2).then.returns(item3)
    datas = [{id: 123},{id: 456},{id: 321}]
    repo = ItemRepository.new(datas)
    assert_equal([item1, item3], repo.find_all_by_price_in_range((4..15)))
  end

  def test_it_can_find_all_items_by_merchant_id
    item1 = stub('Item', id: 123, merchant_id: 1234)
    item2 = stub('Item', id: 456, merchant_id: 4567)
    item3 = stub('Item', id: 321, merchant_id: 1234)
    Item.stubs(:from_raw_hash).returns(item1).then.returns(item2).then.returns(item3)
    datas = [{id: 123}, {id: 456}, {id: 321}]
    repo = ItemRepository.new(datas)
    assert_equal([item1, item3], repo.find_all_by_merchant_id(1234))
  end
end
