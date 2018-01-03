require './test/test_helper'
require './lib/item_repo'

class ItemRepoTest < Minitest::Test

  def test_item_repo_exists
    item_repo = ItemRepo.new

    assert_instance_of ItemRepo, item_repo
  end

end
