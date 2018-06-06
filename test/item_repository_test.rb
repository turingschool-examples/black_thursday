require './test_helper'
require './lib/item'
require './lib/item_repository'
require './lib/file_loader'
require './lib/sales_engine'
require 'bigdecimal'

class ItemRepositoryTest < MiniTest::Test
  def setup
    se = SalesEngine.from_csv({
      :items => "./data/item_sample.csv",
      :merchants => "./data/mock.csv",
      :invoices => "./data/mock.csv",
      :invoice_items => "./data/mock.csv",
      :transactions => "./data/mock.csv",
      :customers => "./data/mock.csv"})

    @ir = se.items
  end

  def test_it_exists
    assert_instance_of ItemRepository, @ir
  end

  def test_items_starts_as_an_empty_array
    assert_instance_of Array, @ir.all
  end

  def test_it_can_create_items
    attributes = {
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now}

    @ir.create(attributes)

    assert_equal 263395239, @ir.all[-2].id
    assert_equal 263395240, @ir.all[-1].id
    assert_equal 'Pencil', @ir.all.last.name
  end

  def test_it_can_return_item_by_its_id
    attributes_1 = {
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now}

    item_1 = @ir.create(attributes_1)

    attributes_2 = {
      :name        => "Pen",
      :description => "You can use it to write other things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now}

    item_2 = @ir.create(attributes_2)

    assert_equal item_1, @ir.find_by_id(263395240)
    assert_equal item_2, @ir.find_by_id(263395241)
  end

  def test_it_returns_nil_if_item_id_is_not_present
    attributes_1 = {
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now}

    item_1 = @ir.create(attributes_1)

    attributes_2 = {
      :name        => "Pen",
      :description => "You can use it to write other things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now}

    item_2 = @ir.create(attributes_2)

    assert_nil @ir.find_by_id(263395245)
  end

  def test_it_can_return_item_by_its_name
    attributes_1 = {
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now}

    item_1 = @ir.create(attributes_1)

    attributes_2 = {
      :name        => "Pen",
      :description => "You can use it to write other things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now}

    item_2 = @ir.create(attributes_2)

    assert_equal item_1, @ir.find_by_name('Pencil')
    assert_equal item_2, @ir.find_by_name('Pen')
  end

  def test_it_returns_nil_if_item_name_is_not_present
    attributes_1 = {
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now}

    item_1 = @ir.create(attributes_1)

    attributes_2 = {
      :name        => "Pen",
      :description => "You can use it to write other things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now
    }
    item_2 = @ir.create(attributes_2)

    assert_nil @ir.find_by_name('Marker')
  end

  def test_item_name_can_be_updated_and_records_date_of_update
    new_attributes_1 = {:name => 'item_4'}
    new_attributes_2 = {:name => 'item_5'}
    new_attributes_3 = {:name => 'item_6'}
    @ir.update(263395237, new_attributes_1)
    @ir.update(263395238, new_attributes_2)
    @ir.update(263395239, new_attributes_3)

    assert_equal 'item_4', @ir.collection[263395237].name
    assert_equal 'item_5', @ir.collection[263395238].name
    assert_equal 'item_6', @ir.collection[263395239].name
  end

  def test_item_can_be_deleted_by_id
    attributes_1 = {
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now}

    item_1 = @ir.create(attributes_1)

    assert_equal item_1, @ir.find_by_id(263395240)

    @ir.delete(263395240)

    assert_nil @ir.find_by_id(263395240)
  end

  def test_find_all_with_description
    attributes_1 = {
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now}

    item_1 = @ir.create(attributes_1)

    attributes_2 = {
      :name        => "Pen",
      :description => "You can use it to write other things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now}

    item_2 = @ir.create(attributes_2)

    assert_equal [item_1, item_2], @ir.find_all_with_description('things')
    assert_equal [item_2], @ir.find_all_with_description('other')
  end

  def test_find_all_by_price
    attributes_1 = {
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now}

    item_1 = @ir.create(attributes_1)

    attributes_2 = {
      :name        => "Pen",
      :description => "You can use it to write other things",
      :unit_price  => BigDecimal.new(11.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now}

    item_2 = @ir.create(attributes_2)

    price_1 = BigDecimal.new(10.99,4)/100
    price_2 = BigDecimal.new(11.99,4)/100

    assert_equal [item_1], @ir.find_all_by_price(price_1)
    assert_equal [item_2], @ir.find_all_by_price(price_2)
  end

  def test_find_all_by_price_in_range
    attributes_1 = {
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now}

    item_1 = @ir.create(attributes_1)

    attributes_2 = {
      :name        => "Pen",
      :description => "You can use it to write other things",
      :unit_price  => BigDecimal.new(11.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now}

    item_2 = @ir.create(attributes_2)

    assert_equal 5, @ir.find_all_by_price_in_range(0..100).length
    assert_equal 2, @ir.find_all_by_price_in_range(11.00..15.00).length
  end

  def test_find_all_by_merchant_id
    attributes_1 = {
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :merchant_id => 12334225,
      :created_at  => Time.now,
      :updated_at  => Time.now}

    item_1 = @ir.create(attributes_1)

    attributes_2 = {
      :name        => "Pen",
      :description => "You can use it to write other things",
      :unit_price  => BigDecimal.new(11.99,4),
      :merchant_id => 12334225,
      :created_at  => Time.now,
      :updated_at  => Time.now}

    item_2 = @ir.create(attributes_2)

    attributes_3 = {
      :name        => "Sharpie",
      :description => "You can use it to write permanently",
      :unit_price  => BigDecimal.new(11.99,4),
      :merchant_id => 12334335,
      :created_at  => Time.now,
      :updated_at  => Time.now}

    item_3 = @ir.create(attributes_3)

    assert_equal [item_1, item_2], @ir.find_all_by_merchant_id(12334225)
    assert_equal [item_3], @ir.find_all_by_merchant_id(12334335)
  end
end
