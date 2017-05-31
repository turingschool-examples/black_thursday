require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/item_repository"

class ItemRepositoryTest < Minitest::Test
  attr_reader :item_repo
  def setup
    @item_repo = ItemRepository.new
  end

  def test_it_exists_and_items_empty_by_default
    assert_instance_of ItemRepository, item_repo
  end


end
