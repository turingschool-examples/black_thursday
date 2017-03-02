require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/repository'
require_relative '../lib/sales_engine'
require_relative '../lib/item_repository'
require_relative '../lib/item'
require_relative '../test/file_hash_setup'


class ItemRepositoryTest < Minitest::Test

  attr_reader :file_hash, :se, :path, :repo, :item_repository

  include FileHashSetup

  def setup
    super
    @path = 'test/fixtures/items_sample.csv'
    @repo = Repository.new(se, path, Item)
    @item_repository = ItemRepository.new(se, path)
  end

  def test_it_finds_all_items
    assert_equal Array, item_repository.all.class
    refute_empty item_repository.all
  end

  def test_count
    assert_equal Fixnum, item_repository.count.class
  end

  def test_it_finds_items_by_id
    assert_equal Item , item_repository.find_by_id(263395237).class
  end

  def test_it_can_find_an_item_by_name
    assert_equal Item , item_repository.find_by_name("510+ RealPush Icon Set").class
  end

  def test_it_can_find_all_with_discription
    assert_equal Array , item_repository.find_all_with_description("Disney glitter frames").class
  end

end
