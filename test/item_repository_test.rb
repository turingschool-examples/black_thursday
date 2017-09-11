require "./test/test_helper"
require "./lib/item_repository"

class ItemRepositoryTest < Minitest::Test

  attr_reader :item_repo

  def setup
    @item_repo = ItemRepository.new
  end

  def test_it_exists
    assert_instance_of ItemRepository, item_repo
  end

end
