require_relative './helper'
require_relative '../lib/item_repository'
require_relative '../lib/item'
require_relative '../lib/sales_engine'
class ItemRepositoryTest < Minitest::Test
  def setup
    se = SalesEngine.from_csv( {
        :items      => "./data/items.csv",
        :merchants  => "./data/merchants.csv"
                             } )
    @ir = se.items
    @time_now = Time.now
    @updated_time = Time.now
  end
  def test_it_exists
    assert_instance_of ItemRepository, @ir
  end

  def test_it_can_return_array_of_all_items
    assert_equal 1367, @ir.all.count
  end

  def test_it_can_find_by_id
    assert_instance_of Item, @ir.find_by_id(263399263)
  end

  def test_it_can_find_by_name
    assert_instance_of Item, @ir.find_by_name('Oak Bowl')
  end

  def test_it_can_find_all_by_name
    assert_equal [], @ir.find_all_by_name('AaronBrooksRoberts')
    assert_equal 3, @ir.find_all_by_name('Oak').count
  end

  def test_it_can_find_all_with_decription
    assert_equal [], @ir.find_all_with_description('bradleyniedt')
    assert_equal 4, @ir.find_all_with_description('ear wire').count
  end

  def test_it_can_find_all_by_price
    assert_equal [], @ir.find_all_by_price(42737)
    assert_equal 7, @ir.find_all_by_price(40000).count
  end

  def test_it_can_find_all_by_price_in_range
    assert_equal [], @ir.find_all_by_price_in_range(1..3)
    assert_equal 110, @ir.find_all_by_price_in_range(300..600).count
  end

  def test_it_can_find_all_by_merchant_id
    assert_equal [], @ir.find_all_by_merchant_id('12345678')
    assert_equal 6, @ir.find_all_by_merchant_id('12334185').count
  end


  def test_it_can_create_new_item
    actual = @ir.create({ name: 'LeahKathrynMiller',
                          description: 'fun',
                          unit_price: '360',
                          created_at: @time_now,
                          updated_at: @updated_time,
                          merchant_id: '73922533'
                          })
    assert_instance_of Item, actual
    assert_equal '263567475', @ir.all.last.id
  end

  def test_it_can_update_attributes
    @ir.update('263397313', { name: 'Super Cool Stuff',
                             description: 'This is really cool',
                             unit_price: '1000000'})
    assert_equal 'Super Cool Stuff', @ir.find_by_id('263397313').name
    assert_equal 'This is really cool', @ir.find_by_id('263397313').description
    assert_equal '1000000', @ir.find_by_id('263397313').unit_price
  end

  def test_it_can_delete_an_item
    @ir.create( {  name: 'LeahKathrynMiller',
                  description: 'fun',
                  unit_price: '360',
                  created_at: @time_now,
                  updated_at: @updated_time,
                  merchant_id: '73922533'
              } )
    @ir.delete('263567475')
    refute @ir.all.any? { |item| item.id == '263567475' }
  end
end
