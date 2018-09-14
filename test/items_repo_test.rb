require 'simplecov'
SimpleCov.start
require 'bigdecimal'
require 'time'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/items_repo'
require_relative '../lib/item'


class ItemsRepoTest < Minitest::Test

  def test_it_exist
    ir = ItemsRepo.new("./test/fixtures/items.csv")
    assert_instance_of ItemsRepo, ir
  end

  def test_it_returns_all_items_in_an_array
    ir = ItemsRepo.new("./test/fixtures/items.csv")
    assert_equal "Cheer bow", ir.all.first.name
    assert_instance_of Array, ir.all
    assert_equal 7, ir.all.count
    assert_equal "Cheer bow", ir.all.first.name
  end

  def test_it_can_find_an_item_by_id
    ir = ItemsRepo.new("./test/fixtures/items.csv")
    actual = ir.find_by_id(1)
    assert_instance_of Item, actual
    assert_equal "Cheer bow", actual.name
    assert_equal 1, actual.id
  end

  def test_it_returns_nil_if_no_id_match_found
    ir = ItemsRepo.new("./test/fixtures/items.csv")
    actual = ir.find_by_id(28349289034)
    assert_nil actual
  end

  def test_it_can_find_an_item_by_name
    ir = ItemsRepo.new("./test/fixtures/items.csv")
    actual = ir.find_by_name("Sal")
    assert_instance_of Item, actual
    assert_equal 4, actual.id
    assert_equal "sal", actual.name
  end

  def test_it_returns_nil_if_no_name_match_found
    ir = ItemsRepo.new("./test/fixtures/items.csv")
    actual = ir.find_by_name("hiiiiiiiii")
    assert_nil actual
  end

  def test_it_can_find_all_with_a_description
    ir = ItemsRepo.new("./test/fixtures/items.csv")

    chicken = ir.find_by_id(3)
    student = ir.find_by_id(7)

    expected = [chicken, student]
    actual = ir.find_all_with_description("eat it")
    assert_equal expected, actual

    assert_equal [], ir.find_all_with_description("jifeowjflsjeioa")
  end

  def test_i_can_find_all_items_with_the_same_price
    ir = ItemsRepo.new("./test/fixtures/items.csv")

    cheer_bow = ir.find_by_id(1)
    student = ir.find_by_id(7)

    expected = [cheer_bow, student]
    actual = ir.find_all_by_price(10.00)

    assert_equal expected, actual
    assert_equal [], ir.find_all_by_price(2492849)
  end

  def test_it_can_find_prices_in_a_range
    ir = ItemsRepo.new("./test/fixtures/items.csv")

    chicken = ir.find_by_id(3)
    brian = ir.find_by_id(5)

    expected = [chicken, brian]
    actual = ir.find_all_by_price_in_range(12.00..15.00)

    assert_equal expected, actual
    assert_equal [], ir.find_all_by_price_in_range(0..1)
  end

  def test_it_finds_all_by_merchant_id
    ir = ItemsRepo.new("./test/fixtures/items.csv")

    cheer_bow = ir.find_by_id(1)
    student = ir.find_by_id(7)

    expected = [cheer_bow, student]
    actual = ir.find_all_by_merchant_id(1)

    assert_equal expected, actual
    assert_equal [], ir.find_all_by_merchant_id(289348)
  end

  def test_it_can_create_a_new_item_with_new_parameters
    ir = ItemsRepo.new("./test/fixtures/items.csv")

    actual  = ir.create({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
                        })

    assert_instance_of Item, actual
  end

  def test_the_new_items_id_increments_by_one
    ir = ItemsRepo.new("./test/fixtures/items.csv")

    actual  = ir.create({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
                        })
    assert_equal 8, actual.id
  end

  def test_it_can_update_items_attributes_with_correspending_id
    ir = ItemsRepo.new("./test/fixtures/items.csv")
    actual = ir.find_by_id(6)
    ir.update(6, {:name => "Dude dog mountain",
                  :description => "Every dating profile in CO ever",
                  :unit_price => BigDecimal.new(10.99,4)})
    assert_equal "Dude dog mountain", actual.name
    assert_equal "Every dating profile in CO ever", actual.description
    assert_equal 10.99, actual.unit_price
    assert_instance_of Time, actual.updated_at
  end

  def test_update_merchant_id_doesnt_work
    ir = ItemsRepo.new("./test/fixtures/items.csv")
    ir.update(6, {:id => 100,
                  :name => "Dude dog mountain",
                  :description => "Every dating profile in CO ever",
                  :unit_price => BigDecimal.new(10.99,4)})

    actual = ir.find_by_name("Dude dog mountain").id

    assert_equal 6, actual
  end

  def test_it_can_delete_the_item_with_corresponding_id
    ir = ItemsRepo.new("./test/fixtures/items.csv")
    ir.delete(1)
    assert_nil ir.find_by_id(1)
  end
end
