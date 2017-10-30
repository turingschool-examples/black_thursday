require_relative 'test_helper'
# require 'minitest/autorun'
# require 'minitest/pride'
# require 'pry'
require './lib/item'
require './lib/item_repo'


class ItemTest < MiniTest::Test

  def setup
    @item_repository = ItemRepo.new
  end

  def test_it_knows_where_it_came_from
    @item_repository.create_item(:name => "The Thing")
    item = @item_repository.items.first
    assert_equal @item_repository, item.parent
  end

end
