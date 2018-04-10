require './test/test_helper'
require './lib/item_repository'
require './lib/item'

class ItemRepositoryTest < Minitest::Test
  def test_it_exists
    ir = ItemRepository.new('./test/fixtures/item_fixture.csv', self)
    assert_instance_of ItemRepository, ir
  end
end
