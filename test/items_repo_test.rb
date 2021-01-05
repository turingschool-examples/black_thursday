require 'CSV'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/items'
require './lib/items_repo'
require 'pry'

class ItemsRepoTest < Minitest::Test

  def setup
    @repo = ItemsRepo.new("./data/items.csv")
  end

  def test_it_is
    assert_instance_of ItemsRepo, @repo
  end

  def test_it_has_attributes
    assert_instance_of Array , @repo.items
  end

  def test_it_can_gather_all_items
    @repo.all
    assert_instance_of Item, @repo.all[0]
    assert_instance_of Item, @repo.all[-1]
    assert_equal 1367, @repo.all.length
  end

end
