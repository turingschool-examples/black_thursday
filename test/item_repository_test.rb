# Frozen_string_literal: true

require './test/test_helper'
require './lib/sales_engine'

class ItemRepositoryTest < Minitest::Test
  attr_reader :se
  def setup
    @se = SalesEngine.from_csv(
  :items     => './test/fixtures/item_fixture.csv',
  :merchants => './test/fixtures/merchant_fixture.csv'
  )
  end

  def test_it_exists
    assert_instance_of ItemRepository, se.items
  end

  def test_it_returns_all_items
    assert_equal 3, se.items.all.count
    assert_instance_of Array, se.items.all
    assert_instance_of Item, se.items.all[0]
  end

  def test_find_by_id
    assert_instance_of Item, se.items.find_by_id(263_399_187)
    assert_equal 'Box', se.items.find_by_id(263_399_187).name
  end

  def test_find_by_name
    assert_instance_of Item, se.items.find_by_name('Box')
    assert_equal 263_399_187, se.items.find_by_name('Box').id
    assert_nil se.items.find_by_name('Emmie')
  end

  def test_find_by_description
    assert_instance_of Array, se.items.find_all_with_description('Brown')
    assert_equal 263_399_187, se.items.find_all_with_description('Brown')[0].id
    assert_equal [], se.items.find_all_with_description('Emmie')
  end

  def test_find_all_by_price
    assert_instance_of Array, se.items.find_all_by_price(24.0)
    assert_equal 263_399_188, se.items.find_all_by_price(24.0)[0].id
    assert_equal [], se.items.find_all_by_price('12')
  end

  def test_find_all_by_price_in_range
    range = (10..9999)

    assert_instance_of Array, se.items.find_all_by_price_in_range(range)
    assert_equal 3, se.items.find_all_by_price_in_range(range).count
  end

  def test_find_by_merchant_id
    assert_instance_of Item, se.items.find_all_by_merchant_id(12334365)[0]
    assert_instance_of Array, se.items.find_all_by_merchant_id(12334365)
    assert_equal 'Brown', se.items.find_all_by_merchant_id(12334365)[0].description
  end

  def test_create_new_item_with_attributes
    attributes = {
        name: 'Capita Defenders of Awesome 2018',
        description: 'This board both rips and shreds',
        unit_price: BigDecimal(399.99, 5),
        created_at: Time.now,
        updated_at: Time.now,
        merchant_id: 25 }

    assert_equal 263_399_189, se.items.create(attributes).id
  end

  def test_it_can_update_an_item
    # this needs refactoring
    decimal = BigDecimal(399.99, 5)
    attributes = {id: '263399188',
                  name: 'Capita Defenders of Awesome 2018',
                  description: 'This board both rips and shreds',
                  unit_price: decimal,
                  created_at: Time.now,
                  updated_at: Time.now,
                  merchant_id: 25}
    id = '263399188'

    assert_equal 'Capita Defenders of Awesome 2018', se.items.update(id, attributes[:name])
  end

  def test_it_can_delete_an_item
    assert_instance_of Item, se.items.delete(263_399_187)
    assert_equal 2, se.items.all.count
  end
end
