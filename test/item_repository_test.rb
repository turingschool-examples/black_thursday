require_relative 'test_helper'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  def setup
    @item_repo = ItemRepository.new('./test/fixtures/items_sample.csv')
  end

  def test_if_it_exists
    assert_instance_of ItemRepository, @item_repo
  end

  def test_if_item_repository_has_items
    assert_instance_of Array, @item_repo.all
    assert_equal 26, @item_repo.all.count
    assert @item_repo.all.all? { |item| item.is_a?(Item)}
  end

end
