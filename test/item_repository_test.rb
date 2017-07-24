require './lib/item_repository'
require 'csv'
require 'minitest/autorun'
require 'minitest/emoji'

class ItemRepositoryTest < Minitest::Test

  def setup
    @mr = ItemRepository.new
  end

  def test_it_exists
    assert_instance_of ItemRepository, @mr
  end

end
