require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repo'
require 'pry'

class ItemRepoTest < MiniTest::Test

  def test_it_exists
    ir = ItemRepo.new("./data/items.csv")

    assert_instance_of ItemRepo, ir
  end

end
