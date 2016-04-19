require "minitest/autorun"
require "./lib/item_repo"
require "csv"


class ItemRepoTest < Minitest::Test

  def test_item_repo_exists
    repo = MerchantRepo.new
    assert repo
  end

  def test_if_items_array_created
    repo = MerchantRepo.new
    assert_equal Array, repo.items.class
  end

end
