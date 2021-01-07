require_relative './test_helper'
# require './lib/item'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  def test_it_exists_and_has_attributes
    i_repo = ItemRepository.new("./data/merchants.csv", engine)

    assert_instance_of ItemRepository, i_repo
  end
end
