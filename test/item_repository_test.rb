require_relative 'test_helper'


class ItemRepositoryTest < Minitest::Test
  def setup
    @path = "./data/items_fixture.csv"
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
#     assert_equal "Disney scrabble frames
#     assert_equal "12334185", merchant_id
#   end

  def test_can_find_by_name
    ir = ItemRepository.new(@path)
    found = ir.find_by_name("Glitter scrabble frames")
    assert_equal "Glitter scrabble frames", found.name
  end

  def test_that_all_returns_an_array
    ir = ItemRepository.new(@path)
    all_items = ir.all

    refute all_items.empty?
    assert_instance_of Item, all_items[0]
  end

  def test_can_find_by_id
    ir = ItemRepository.new(@path)
    found = ir.find_by_id(263395237)
    not_found = ir.find_by_id(9999999)

    # binding.pry
    assert_equal 263395237, found.id
    assert_nil not_found
  end

  def test_can_find_by_description
    ir = ItemRepository.new(@path)
    found = ir.find_all_with_description("This is THE DESCRiption")
    assert_equal "this is the description", found[0].description
  end

  def test_can_find_all_by_price
    ir = ItemRepository.new(@path)
    found = ir.find_all_by_price(13.50)
    not_found = ir.find_all_by_price(9999999)

    assert_equal 13.50, found[0].unit_price
    assert_equal [], not_found
  end

  def test_can_find_all_by_price_in_range
    ir = ItemRepository.new(@path)
    found = ir.find_all_by_price_in_range((11.00..14.00))
    not_found = ir.find_all_by_price_in_range((1.0..2.5))


    assert_instance_of Array, found
    assert_equal 12.00, found[0].unit_price
    assert_equal 13.50, found[1].unit_price
    assert_equal [], not_found
  end

#note: found.count depends on fixtures file. Update.
  def test_can_find_all_by_merchant_id
    ir = ItemRepository.new(@path)
    found = ir.find_all_by_merchant_id(12334185)
    assert_equal 12334185, found[0].merchant_id
    assert_equal 2, found.count
  end


end