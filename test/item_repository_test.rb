require './test/test_helper'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  def test_it_created_instance_of_item_repo_class
    i = ItemRepository.new
    assert_equal ItemRepository, i.class
  end
end
