require 'minitest/autorun'
require 'minitest/emoji'
require_relative '../lib/itemrepository'
require 'csv'
class ItemRepositoryTest < Minitest::Test
  def sample_path
    "./test/itemreposample.csv"
  end

  def instance
    {"id"=>"263395721",
   "name"=>"Disney scrabble frames",
   "description"=>
    "Disney glitter frames\n\nAny colour glitter available and can do any characters you require\n\nDifferent colour scrabble tiles\n\nBlue\nBlack\nPink\nWooden",
   "unit_price"=>"1350",
   "merchant_id"=>"12334185",
   "created_at"=>"2016-01-11 11:51:37 UTC",
   "updated_at"=>"2008-04-02 13:48:57 UTC"}
  end

  def test_it_exists
    ir = ItemRepository.new(sample_path, nil)

    assert_instance_of ItemRepository, ir
  end

  def test_initializes_with_file_path
    ir = ItemRepository.new(sample_path, nil)

    assert_equal sample_path, ir.file_path
  end

  def test_content_is_nil_by_default
    ir = ItemRepository.new(sample_path, nil)

    assert_nil ir.content
  end

  def test_find_all_instance
  end

  def test_return_instance_or_nil_with_id
    ir = ItemRepository.new(sample_path, nil)
    ir.organize

    assert_nil ir.find_by_id(0)
    assert_equal instance, ir.find_by_id(263395721).information
  end

  def test_return_instance_or_nil_with_name
    ir = ItemRepository.new(sample_path, nil)
    ir.organize

    assert_nil ir.find_by_name("hello")
    assert_equal instance, ir.find_by_name("Disney scrabble frames").information
  end

end
