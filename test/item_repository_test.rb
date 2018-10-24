require './test/test_helper'

class ItemRepositoryTest < Minitest::Test

  def test_it_exists
    require 'pry';binding.pry
    i = Item.new('./test/item_sample.csv')
    assert_instance_of ItemRepository, i
  end

end
