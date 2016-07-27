require './test/test_helper'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  def test_it_exists
    assert ItemRepository.new(item)
  end

  # def test_it_
end
