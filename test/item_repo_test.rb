require_relative 'test_helper'
require_relative '../lib/item_repo'
require_relative '../lib/sales_engine'

class ItemRepositoryTest < Minitest::Test
  attr_reader :item_repo, :sales_engine

  def set_up(items = [])
    @sales_engine = SalesEngine.new
    @item_repo = ItemRepository.new(items, sales_engine)
    @sales_engine.items = item_repo
  end

  def test_item_exists
    set_up
    assert_instance_of ItemRepository, item_repo
  end

  def test_all
    items = []
    items << Item.new({ :id => "263395237", :name => "510+ RealPush Icon Set", :description => "hi",:merchant_id => "123", :unit_price => "1200", :created_at => "2016-01-11 09:34:06 UTC", :updated_at => "2007-06-04 21:35:10 UTC"})
    items << Item.new({ :id => "263395238", :name => "Icon Set", :description => "hello",:merchant_id => "223", :unit_price => "1201", :created_at => "2016-01-11 09:34:06 UTC", :updated_at => "2007-06-04 21:35:10 UTC"})
    set_up(items)

    assert_equal 2, item_repo.items.count
  end

  def test_find_by_exisiting_id
    items = []
    items << Item.new({ :id => "263395237", :name => "510+ RealPush Icon Set", :description => "hi",:merchant_id => "123", :unit_price => "1200", :created_at => "2016-01-11 09:34:06 UTC", :updated_at => "2007-06-04 21:35:10 UTC"})
    items << Item.new({ :id => "263395238", :name => "Icon Set", :description => "hello",:merchant_id => "223", :unit_price => "1201", :created_at => "2016-01-11 09:34:06 UTC", :updated_at => "2007-06-04 21:35:10 UTC"})
    set_up(items)

    assert_instance_of Item, item_repo.find_by_id(263395237)
  end

  def test_find_by_id_nil
    items = []
    items << Item.new({ :id => "263395237", :name => "510+ RealPush Icon Set", :description => "hi",:merchant_id => "123", :unit_price => "1200", :created_at => "2016-01-11 09:34:06 UTC", :updated_at => "2007-06-04 21:35:10 UTC"})
    items << Item.new({ :id => "263395238", :name => "Icon Set", :description => "hello",:merchant_id => "223", :unit_price => "1201", :created_at => "2016-01-11 09:34:06 UTC", :updated_at => "2007-06-04 21:35:10 UTC"})
    set_up(items)

    assert_nil item_repo.find_by_id(263395230)
  end

  def test_find_by_name_nil
    items = []
    items << Item.new({ :id => "263395237", :name => "510+ RealPush Icon Set", :description => "hi",:merchant_id => "123", :unit_price => "1200", :created_at => "2016-01-11 09:34:06 UTC", :updated_at => "2007-06-04 21:35:10 UTC"})
    items << Item.new({ :id => "263395238", :name => "Icon Set", :description => "hello",:merchant_id => "223", :unit_price => "1201", :created_at => "2016-01-11 09:34:06 UTC", :updated_at => "2007-06-04 21:35:10 UTC"})
    set_up(items)

    assert_nil item_repo.find_by_name("Kool-Aid")
  end

  def test_find_by_name_exists
    items = []
    items << Item.new({ :id => "263395237", :name => "510+ RealPush Icon Set", :description => "hi",:merchant_id => "123", :unit_price => "1200", :created_at => "2016-01-11 09:34:06 UTC", :updated_at => "2007-06-04 21:35:10 UTC"})
    items << Item.new({ :id => "263395238", :name => "Icon Set", :description => "hello",:merchant_id => "223", :unit_price => "1201", :created_at => "2016-01-11 09:34:06 UTC", :updated_at => "2007-06-04 21:35:10 UTC"})
    set_up(items)

    assert_instance_of Item, item_repo.find_by_name("Icon Set")
  end

  def test_find_by_all_with_description_word_exists
    items = []
    items << Item.new({ :id => "263395237", :name => "510+ RealPush Icon Set", :description => "hi",:merchant_id => "123", :unit_price => "1200", :created_at => "2016-01-11 09:34:06 UTC", :updated_at => "2007-06-04 21:35:10 UTC"})
    items << Item.new({ :id => "263395238", :name => "Icon Set", :description => "hello",:merchant_id => "223", :unit_price => "1201", :created_at => "2016-01-11 09:34:06 UTC", :updated_at => "2007-06-04 21:35:10 UTC"})
    set_up(items)

    assert_equal 1, item_repo.find_all_with_description("he").count
  end

  def test_find_by_all_with_description_word_empty_array
    items = []
    items << Item.new({ :id => "263395237", :name => "510+ RealPush Icon Set", :description => "hi",:merchant_id => "123", :unit_price => "1200", :created_at => "2016-01-11 09:34:06 UTC", :updated_at => "2007-06-04 21:35:10 UTC"})
    items << Item.new({ :id => "263395238", :name => "Icon Set", :description => "hello",:merchant_id => "223", :unit_price => "1201", :created_at => "2016-01-11 09:34:06 UTC", :updated_at => "2007-06-04 21:35:10 UTC"})
    set_up(items)

    assert_equal [], item_repo.find_all_with_description("no")
  end

  def test_find_by_all_by_price_empty_array
    items = []
    items << Item.new({ :id => "263395237", :name => "510+ RealPush Icon Set", :description => "hi",:merchant_id => "123", :unit_price => "1200", :created_at => "2016-01-11 09:34:06 UTC", :updated_at => "2007-06-04 21:35:10 UTC"})
    items << Item.new({ :id => "263395238", :name => "Icon Set", :description => "hello",:merchant_id => "223", :unit_price => "1201", :created_at => "2016-01-11 09:34:06 UTC", :updated_at => "2007-06-04 21:35:10 UTC"})
    set_up(items)

    assert_equal [], item_repo.find_all_by_price(5.00)
  end

  def test_find_by_all_by_existing_price
    items = []
    items << Item.new({ :id => "263395237", :name => "510+ RealPush Icon Set", :description => "hi",:merchant_id => "123", :unit_price => "1200", :created_at => "2016-01-11 09:34:06 UTC", :updated_at => "2007-06-04 21:35:10 UTC"})
    items << Item.new({ :id => "263395238", :name => "Icon Set", :description => "hello",:merchant_id => "223", :unit_price => "1201", :created_at => "2016-01-11 09:34:06 UTC", :updated_at => "2007-06-04 21:35:10 UTC"})
    set_up(items)

    assert_equal 1, item_repo.find_all_by_price(12.01).count
  end

  def test_find_by_all_by_price_range_price_exists_in_range
    items = []
    items << Item.new({ :id => "263395237", :name => "510+ RealPush Icon Set", :description => "hi",:merchant_id => "123", :unit_price => "1200", :created_at => "2016-01-11 09:34:06 UTC", :updated_at => "2007-06-04 21:35:10 UTC"})
    items << Item.new({ :id => "263395238", :name => "Icon Set", :description => "hello",:merchant_id => "223", :unit_price => "1201", :created_at => "2016-01-11 09:34:06 UTC", :updated_at => "2007-06-04 21:35:10 UTC"})
    set_up(items)

    assert_equal 2, item_repo.find_all_by_price_in_range(10.00..15.00).count
  end

  def test_find_by_all_by_price_range_empty_array
    items = []
    items << Item.new({ :id => "263395237", :name => "510+ RealPush Icon Set", :description => "hi",:merchant_id => "123", :unit_price => "1200", :created_at => "2016-01-11 09:34:06 UTC", :updated_at => "2007-06-04 21:35:10 UTC"})
    items << Item.new({ :id => "263395238", :name => "Icon Set", :description => "hello",:merchant_id => "223", :unit_price => "1201", :created_at => "2016-01-11 09:34:06 UTC", :updated_at => "2007-06-04 21:35:10 UTC"})
    set_up(items)

    assert_equal [], item_repo.find_all_by_price_in_range(1.00..5.00)
  end

  def test_find_by_all_by_merchant_id_empty_array
    items = []
    items << Item.new({ :id => "263395237", :name => "510+ RealPush Icon Set", :description => "hi",:merchant_id => "123", :unit_price => "1200", :created_at => "2016-01-11 09:34:06 UTC", :updated_at => "2007-06-04 21:35:10 UTC"})
    items << Item.new({ :id => "263395238", :name => "Icon Set", :description => "hello",:merchant_id => "223", :unit_price => "1201", :created_at => "2016-01-11 09:34:06 UTC", :updated_at => "2007-06-04 21:35:10 UTC"})
    set_up(items)

    assert_equal [], item_repo.find_all_by_merchant_id("3")
  end

  def test_find_by_all_by_merchant_id_exists
    items = []
    items << Item.new({ :id => "263395237", :name => "510+ RealPush Icon Set", :description => "hi",:merchant_id => "123", :unit_price => "1200", :created_at => "2016-01-11 09:34:06 UTC", :updated_at => "2007-06-04 21:35:10 UTC"})
    items << Item.new({ :id => "263395238", :name => "Icon Set", :description => "hello",:merchant_id => "223", :unit_price => "1201", :created_at => "2016-01-11 09:34:06 UTC", :updated_at => "2007-06-04 21:35:10 UTC"})
    set_up(items)

    assert_equal 1, item_repo.find_all_by_merchant_id(123).count
  end

end
