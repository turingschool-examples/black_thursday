require './test/test_helper'
require './lib/sales_engine'
require './lib/item_repository'


class ItemRepositoryTest < Minitest::Test

  def test_setup
    assert ItemRepository.new.class
  end
end
