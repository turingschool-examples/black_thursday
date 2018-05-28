require './test/test_helper.rb'
require './lib/item_repository.rb'
require './lib/file_loader.rb'

class ItemRepositoryTest < Minitest::Test
  include FileLoader

  def test_it_exists
    ir = ItemRepository.new(load_file("./data/items.csv"))
    assert_instance_of ItemRepository, ir
  end

  def test_it_makes_a_repository_of_items
    ir = ItemRepository.new(load_file("./data/items.csv"))
    assert_equal 1367, ir.repository.count
  end

  def test_it_will_return_all_entire_repository
    ir = ItemRepository.new(load_file("./data/items.csv"))
    assert_equal ir.repository, ir.all
  end

  def test_it_can_find_by_id_number
    ir = ItemRepository.new(load_file("./data/items.csv"))
    id = 263538760
    name = "Puppy blankie"
    assert_equal ir.find_by_name(name), ir.find_by_id(id)
  end

  def test_it_can_find_by_name
    ir = ItemRepository.new(load_file("./data/items.csv"))
    id = 263395721
    name = "Disney scrabble frames"
    assert_equal ir.find_by_id(id), ir.find_by_name(name)
  end

  def test_it_can_find_by_description
    ir = ItemRepository.new(load_file("./data/items.csv"))
    id = 263395721
    description = "Disney glitter"
    assert_equal [ir.find_by_id(id)], ir.find_all_with_description(description)
  end

  def test_it_can_find_all_items_at_a_price
    ir = ItemRepository.new(load_file("./data/items.csv"))
    assert_equal 58, ir.find_all_by_price(1500).count
  end

  def test_it_can_find_all_items_within_a_price_range
    ir = ItemRepository.new(load_file("./data/items.csv"))
    assert_equal 66, ir.find_all_by_price_in_range(1000..1100).count
  end

  def test_it_can_find_items_with_the_same_merchant_id
    ir = ItemRepository.new(load_file("./data/items.csv"))
    assert_equal 4, ir.find_all_by_merchant_id(12334871).count
  end

  def test_it_can_create_a_new_entry
    ir = ItemRepository.new(load_file("./data/items.csv"))
    attributes = {
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
    }
    ir.create(attributes)
    sorted = ir.repository.sort_by { |item| item.id }
    assert_equal ir.find_by_id(263567475), sorted.last
    assert_equal ir.find_by_id(263567475).name, 'Pencil'
  end

  def test_it_can_update
    ir = ItemRepository.new(load_file("./data/items.csv"))
    attributes = {
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
    }
    ir.create(attributes)
    new_attributes = {
      :name => "Pen",
      :description => "Now in ink",
      :unit_price => BigDecimal.new(11.00,4)
    }
    id = 263567475
    ir.update(id, new_attributes)
    assert_equal "Pen", ir.find_by_id(263567475).name
  end

  def test_it_can_delete_an_entry
    ir = ItemRepository.new(load_file("./data/items.csv"))
    attributes = {
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
    }
    ir.create(attributes)
    ir.delete(263567475)
    assert_equal nil, ir.find_by_id(263567475)
  end

end
