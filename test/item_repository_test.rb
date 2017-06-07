require_relative 'test_helper.rb'
require_relative '../lib/item_repository'
class ItemRepositoryTest < Minitest::Test
  def sample_path
    "./test/data/itemreposample.csv"
  end

  def test_it_exists
    ir = ItemRepository.new(sample_path, nil)

    assert_instance_of ItemRepository, ir
  end

  def test_initializes_with_file_path
    ir = ItemRepository.new(sample_path, nil)

    assert_equal sample_path, ir.file_path
  end

  def test_return_instance_or_nil_with_id
    ir = ItemRepository.new(sample_path, nil)
    ir.load_library
    a = ir.find_by_id(0)

    assert_nil a

    b = ir.find_by_id(263395617)

    assert_equal "Glitter scrabble frames", b.name
  end

  def test_return_instance_or_nil_with_name
    ir = ItemRepository.new(sample_path, nil)
    ir.load_library
    a = ir.find_by_name("Glitter scrabble frames")

    assert_nil ir.find_by_name("hello")
    assert_equal "Glitter scrabble frames", a.name
  end

  def test_find_all_item_instances
    ir = ItemRepository.new(sample_path, nil)
    a = ir.all

    assert_equal "Glitter scrabble frames", a[0].name
  end

  def test_find_all_with_description
    ir = ItemRepository.new(sample_path, nil)
    ir.load_library
    a = ir.find_all_with_description("free")
    assert_equal "Free standing Woden letters", a[0].name
  end

  def test_find_all_by_price
    ir = ItemRepository.new(sample_path, nil)
    ir.load_library
    a = ir.find_all_by_price(13.50)

    assert_equal "Disney scrabble frames", a[0].name
  end

  def test_find_all_by_price_range
    ir = ItemRepository.new(sample_path, nil)
    ir.load_library
    a = ir.find_all_by_price_in_range(13.00..14.00)

    assert_equal "Glitter scrabble frames", a[0].name
  end

  def test_find_all_by_merchant_id
    ir = ItemRepository.new(sample_path, nil)
    ir.load_library
    a = ir.find_all_by_merchant_id(12334185)

    assert_equal "Glitter scrabble frames", a[0].name
  end
end
