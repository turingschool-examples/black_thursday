require_relative 'test_helper'


class ItemRepositoryTest < Minitest::Test
  def setup
    @path = "./data/items_fixtures.csv"
  end
  
  def test_it_exist
    ir = ItemRepository.new(@path)
    assert_instance_of ItemRepository, ir
  end

  def test_if_path_is_CSV_object
    ir = ItemRepository.new(@path)
    assert_instance_of CSV, ir.csv_file
  end

  def test_initializes_with_populated_array
    ir = ItemRepository.new(@path)
    refute ir.all.empty?
  end

  def test_items_populate_array
    ir = ItemRepository.new(@path)
    ir.make_items
    refute ir.all.empty?
    assert_instance_of Item, ir.all[0]
  end

# #Refactor headers test
#   def test_can_pull_csv_headers
#     skip
#     ir = ItemRepository.new(@path)
#     name = nil
#     merchant_id = nil
#     @path.each do |row|
#      name = row[:name]
#      merchant_id = row[:merchant_id]
#     end
#     assert_equal "Disney scrabble frames", ir.make_items
#     assert_equal "12334185", merchant_id
#   end

  def test_can_find_by_name
    ir = ItemRepository.new(@path)
    ir.make_items
    found = ir.find_by_name("Glitter scrabble frames")
    assert_equal "Glitter scrabble frames", found.name
  end


  def test_that_all_returns_an_array
    ir = ItemRepository.new(@path)
    ir.make_items
    all_items = ir.all

    refute all_items.empty?
    assert_instance_of Item, all_items[0]
  end

  def test_can_find_by_id
    ir = ItemRepository.new(@path)
    ir.make_items
    found = ir.find_by_id(263395237)
    not_found = ir.find_by_id(9999999)

    assert_equal 263395237, found.id
    assert_nil not_found
  end

  def test_can_find_by_description
    ir = ItemRepository.new(@path)
    ir.make_items
    found = ir.find_by_description("This is THE DescRiption")
    assert_equal "this is the description", found[0].description
  end

  # def test_can_find_all_by_price
  # end

  # def test_can_find_all_by_price_in_range
  # end


  def test_set_time
  end

  def test_updates_current_date
  end

#note: found.count depends on fixtures file. Update.
  def test_can_find_all_by_merchant_id
    ir = ItemRepository.new(@path)
    ir.make_items
    found = ir.find_all_by_merchant_id(12334185)
    assert_equal 12334185, found[0].merchant_id
    assert_equal 2, found.count
  end


end