require './test_helper'
require './lib/item'
require './lib/item_repository'
require './lib/file_loader'

class ItemRepositoryTest < MiniTest::Test
  include FileLoader
  def test_it_exists
    # data_from_file = load('./data/item_sample.csv')
    ir =ItemRepository.new(data_from_file)

    assert_instance_of ItemRepository, ir
  end

end
