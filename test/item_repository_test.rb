require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repository'
require './lib/file_loader'


class ItemRepositoryTest < MiniTest::Test
  include FileLoader

  def setup
    @irepo = ItemRepository.new(load_file('./data/merchants.csv'))
  end

  def test_existence
    assert_instance_of ItemRepository, @irepo
  end

end
