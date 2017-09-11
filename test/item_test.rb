require './test/test_helper'


class ItemTest < Minitest::Test

  def test_instance_of_Item_exists
    i = Item.new

    assert_instance_of Item, i
  end

  def test_id_returns_the_integer_id_of_the_item
    i = Item.new({
    :id          => "1",
    :name        => "Pencil",
    :description => "You can use it to write things",
    :unit_price  => BigDecimal.new(10.99,4),
    :created_at  => Time.now,
    :updated_at  => Time.now,
    :merchant_id => "33"
  })

  assert_equal "1" , i.id
  end

  def test_id_returns_the_integer_id_of_the_item
    i = Item.new({
    :id          => "1",
    :name        => "Pencil",
    :description => "You can use it to write things",
    :unit_price  => BigDecimal.new(10.99,4),
    :created_at  => Time.now,
    :updated_at  => Time.now,
    :merchant_id => "33"
  })

  assert_equal "1" , i.id
  end

  def test_name_returns_the_name_of_the_item
    i = Item.new({
    :id          => "1",
    :name        => "Pencil",
    :description => "You can use it to write things",
    :unit_price  => BigDecimal.new(10.99,4),
    :created_at  => Time.now,
    :updated_at  => Time.now,
    :merchant_id => "33"
  })

  assert_equal "Pencil" , i.name
  end

  def test_decription_returns_the_description_of_the_item
    i = Item.new({
    :id          => "1",
    :name        => "Pencil",
    :description => "You can use it to write things",
    :unit_price  => BigDecimal.new(10.99,4),
    :created_at  => Time.now,
    :updated_at  => Time.now,
    :merchant_id => "33"
  })

  assert_equal "You can use it to write things" , i.description
  end


  def test_unit_price_returns_the_price_of_the_item
    i = Item.new({
    :id          => "1",
    :name        => "Pencil",
    :description => "You can use it to write things",
    :unit_price  => BigDecimal.new(10.99,4),
    :created_at  => Time.now,
    :updated_at  => Time.now,
    :merchant_id => "33"
  })

  assert_equal  BigDecimal.new(10.99,4), i.unit_price
  end

  def test_created_at_returns_a_Time_instance_for_the_date
    i = Item.new({
    :id          => "1",
    :name        => "Pencil",
    :description => "You can use it to write things",
    :unit_price  => BigDecimal.new(10.99,4),
    :created_at  => Time.now,
    :updated_at  => Time.now,
    :merchant_id => "33"
  })

  assert_equal Time.now, i.created_at
  end

  def test_updated_at_returns_a_Time_instance_for_the_date_last_modified
    i = Item.new({
    :id          => "1",
    :name        => "Pencil",
    :description => "You can use it to write things",
    :unit_price  => BigDecimal.new(10.99,4),
    :created_at  => Time.now,
    :updated_at  => Time.now,
    :merchant_id => "33"
  })

  assert_equal Time.now, i.updated_at
  end

  def test_merchant_id_returns_the_integer_merchant
    i = Item.new({
    :id          => "1",
    :name        => "Pencil",
    :description => "You can use it to write things",
    :unit_price  => BigDecimal.new(10.99,4),
    :created_at  => Time.now,
    :updated_at  => Time.now,
    :merchant_id => "33"
  })

  assert_equal "33", i.merchant_id
  end


end
