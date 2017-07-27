require './test/test_helper'
require_relative '../lib/item_repo'

class ItemRepoTest < Minitest::Test
  attr_reader :ir

  def setup
   @ir = ItemRepo.new("./data/items.csv")
  end

  def test_find_all_items
   assert_equal 1367, ir.all.count
  end
end
