require_relative 'test_helper'
# require 'minitest/autorun'
# require 'minitest/pride'
# require 'pry'
require './lib/item_repo'


class ItemRepositoryTest < MiniTest::Test

  def setup
    @item_repository = ItemRepo.new
  end


  def test_it_creates_items
    assert_equal 0, @item_repository.count
    @item_repository.create_item(:name => "sample 1")
    @item_repository.create_item(:name => "sample 2")
    assert_equal 2, @item_repository.count
    assert_equal "sample 1", @item_repository.items[0].name
    assert_equal "sample 2", @item_repository.items[1].name
  end

end
