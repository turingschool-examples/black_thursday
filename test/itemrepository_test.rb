require 'minitest/autorun'
require 'minitest/emoji'
require './lib/itemrepository'
require 'csv'
class ItemRepositoryTest < Minitest::Test
  def sample_path
    "./test/itemreposample.csv"
  end
  def test_it_exists
    ir = ItemRepository.new(sample_path)

    assert_instance_of ItemRepository, ir
  end

  def test_initializes_with_file_path
    ir = ItemRepository.new(sample_path)

    assert_equal sample_path, ir.file_path
  end

  def test_content_is_nil_by_default
    ir = ItemRepository.new(sample_path)

    assert_nil ir.content
  end

  def test_return_instance_or_nil_with_id
    ir = ItemRepository.new(sample_path)
    ir.organize
    instance = 


end
