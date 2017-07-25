require 'simplecov'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repo'

class ItemRepositoryTest < Minitest::Test

  def test_it_exist
    item_repo = Item_Repo.new

    assert_instance_of Item_Repo, item_repo
  end

end
