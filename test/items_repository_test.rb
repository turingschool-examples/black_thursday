require_relative 'test_helper'
require './lib/items_repository'
require 'csv'

class ItemsRepositoryTest < Minitest::Test
  def setup
    items = CSV.open './data/test_items.csv',
                      headers: true,
                      header_converters: :symbol
    @ir = ItemsRepository.new(items)
  end

  def test_items_repo_exists
    assert_instance_of ItemsRepository, @ir
  end

  def test_it_initializes_empty
    assert_equal [], @ir.all
  end

  def test_it_can_load_items
    csv = @ir.items_csv
    @ir.load_items(csv)

    assert_equal 5, @ir.all.length
  end

  def test_find_by_id
    csv = @ir.items_csv
    @ir.load_items(csv)

    nil_id = 1984
    assert_nil @ir.find_by_id(nil_id)

    real_id = 263395237
    assert_instance_of Item, @ir.find_by_id(real_id)
  end

  def test_find_by_name
    csv = @ir.items_csv
    @ir.load_items(csv)

    nil_name = "Powell's Magic Shop"
    assert_nil @ir.find_by_id(nil_name)

    real_name = 'Glitter scrabble frames'
    assert_instance_of Item, @ir.find_by_name(real_name)
  end

  def test_find_all_with_description
    csv = @ir.items_csv
    @ir.load_items(csv)

    desc_1 = 'Bob Dobbs'
    assert_equal [], @ir.find_all_with_description(desc_1)

    desc_2 = 'Givenchy'
    assert_equal 1, @ir.find_all_with_description(desc_2).length
  end

  def test_find_all_by_price
    csv = @ir.items_csv
    @ir.load_items(csv)

    price_1 = 1_000_000_000
    assert_equal [], @ir.find_all_by_price(price_1)

    price_2 = 1350
    assert_equal 1, @ir.find_all_by_price(price_2).length
  end

  def test_find_all_by_price_in_range
    csv = @ir.items_csv
    @ir.load_items(csv)

    range_1 = (-50..0)
    assert_equal [], @ir.find_all_by_price_in_range(range_1)

    range_2 = (0..1500)
    assert_equal 4, @ir.find_all_by_price_in_range(range_2).length
  end

  def test_find_all_by_merchant_id
    csv = @ir.items_csv
    @ir.load_items(csv)

    id_1 = 1984
    assert_equal [], @ir.find_all_by_merchant_id(id_1)

    id_2 = 12334185
    assert_instance_of Item, @ir.find_all_by_merchant_id(id_2)[0]
    assert_instance_of Item, @ir.find_all_by_merchant_id(id_2)[1]
    assert_instance_of Item, @ir.find_all_by_merchant_id(id_2)[2]
  end

  def test_create
    csv = @ir.items_csv
    @ir.load_items(csv)
    attributes = ({:id          => nil,
                   :name        => 'Pencil',
                   :description => 'You can use it to write things',
                   :unit_price  => BigDecimal.new(10.99,4),
                   :created_at  => Time.now,
                   :updated_at  => Time.now
                    })

    @ir.create(attributes)
    assert_equal 'Pencil', @ir.all.last.name
    assert_equal 1099, @ir.all.last.unit_price
    assert_equal 263396210, @ir.all.last.id
    assert_equal Time.now.hour, @ir.all.last.created_at.hour
  end

  def test_update
    csv = @ir.items_csv
    @ir.load_items(csv)
    attributes = ({:id          => nil,
                   :name        => 'Pencil',
                   :description => 'You can use it to write things',
                   :unit_price  => BigDecimal.new(10.99,4),
                   :created_at  => Time.now,
                   :updated_at  => Time.now
                    })

    @ir.create(attributes)

    item_id = 263396210
    updated_attributes = ({:name        => 'Broken Pencil',
                           :description => 'Useless',
                           :unit_price  => BigDecimal.new(50.50, 4)})
    @ir.update(item_id, updated_attributes)

    assert_equal 'Broken Pencil', @ir.find_by_id(item_id).name
    assert_equal 'Useless', @ir.find_by_id(item_id).description
    assert_equal 5050, @ir.find_by_id(item_id).unit_price
  end

  def test_delete
    csv = @ir.items_csv
    @ir.load_items(csv)

    attributes = ({:id          => nil,
                   :name        => 'Pencil',
                   :description => 'You can use it to write things',
                   :unit_price  => BigDecimal.new(10.99,4),
                   :created_at  => Time.now,
                   :updated_at  => Time.now
                    })

    @ir.create(attributes)

    assert_equal 6, @ir.all.length

    item_id = 263396210

    @ir.delete(item_id)

    assert_equal 5, @ir.all.length
  end
end
