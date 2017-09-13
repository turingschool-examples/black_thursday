require_relative 'test/test_helper'
require_relative 'lib/item_repo'

class ItemRepositoryTest < Minitest::Test

  def test_item_exists
    item = ItemRepository.new

    assert_instance_of ItemRepository, item
  end

end
