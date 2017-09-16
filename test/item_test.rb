require 'bigdecimal'
require 'time'

require './test/test_helper'

require './lib/item'
require './lib/merchant'


class ItemTest < Minitest::Test

  def new_item(data)
    Fixture.new_record(:items, data)
  end

  def item_263407925
    Fixture.find_record(:items, 263407925)
  end

  def item_263407925_expected
    {
      id:           263407925,
      merchant_id:  12334123,
      name:         'Adidas Breitner Super Fußballschuh',
      description:  'Adidas Breitner Super mit Nocken. Hergestellt ab dem Jahr 1983.',
      unit_price:   BigDecimal.new('100'),
      created_at:   Time.parse('2016-01-11 13:48:51 UTC'),
      updated_at:   Time.parse('2002-03-25 20:00:24 UTC')
    }
  end



  def test_initialize_takes_a_hash_of_strings
    assert_instance_of Item, new_item({
      id:          '1',
      merchant_id: '1',
      name:        'item 1',
      description: 'item 1',
      unit_price: '100',
      created_at: '2016-01-11 13:48:51 UTC',
      updated_at: '2002-03-25 20:00:24 UTC'
    })
  end

  def test_it_has_an_Integer_id
    assert_equal 263407925, item_263407925.id
  end

  def test_it_has_an_Integer_merchant_id
    assert_equal item_263407925_expected[:merchant_id], item_263407925.merchant_id
  end

  def test_it_has_a_String_name
    assert_equal item_263407925_expected[:name], item_263407925.name
  end

  def test_it_has_a_String_description
    assert_equal item_263407925_expected[:description], item_263407925.description
  end

  def test_it_has_a_BigDecimal_unit_price
    assert_equal item_263407925_expected[:unit_price], item_263407925.unit_price
  end

  def test_it_has_a_Time_created_at
    assert_equal item_263407925_expected[:created_at], item_263407925.created_at
  end

  def test_it_has_a_Time_updated_at
    assert_equal item_263407925_expected[:updated_at], item_263407925.updated_at
  end

  def test_id_defaults_to_Integer
    item = new_item({
      merchant_id: '1',
      name:        'item 1',
      description: 'item 1',
      unit_price: '100',
      created_at: '2016-01-11 13:48:51 UTC',
      updated_at: '2002-03-25 20:00:24 UTC'
    })
    assert_instance_of Integer, item.id
  end

  def test_created_at_defaults_to_Time
    item = new_item({
      id:          '1',
      merchant_id: '1',
      name:        'item 1',
      description: 'item 1',
      unit_price: '100',
      updated_at: '2002-03-25 20:00:24 UTC'
    })
    assert_instance_of Time, item.created_at
  end

  def test_updated_at_defaults_to_Time
    item = new_item({
      id:          '1',
      merchant_id: '1',
      name:        'item 1',
      description: 'item 1',
      unit_price: '100',
      created_at: '2016-01-11 13:48:51 UTC'
    })
    assert_instance_of Time, item.created_at
  end

  def test_merchant_returns_a_single_merchant
    assert_instance_of Merchant, item_263407925.merchant
  end

  def test_merchant_has_id_same_as_merchant_id
    assert_equal item_263407925_expected[:merchant_id], item_263407925.merchant.id
  end

end
