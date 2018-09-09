require 'bigdecimal'
require 'time'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/items_repo'
require './lib/item'
require 'pry'


class ItemsRepoTest < Minitest::Test
  def test_it_exist
    ir = ItemsRepo.new("./test/fixtures/items.csv")

    assert_instance_of ItemsRepo, ir
  end


end
