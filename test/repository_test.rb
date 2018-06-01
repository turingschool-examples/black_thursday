require './test/test_helper'
require './lib/repository'
require './lib/sales_engine'

class RepositoryTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv()
    @repo = Repository.new
  end

  def test_it_exists
    assert_instance_of Repository, @repo
  end

  def test_repository_members_starts_empty
    assert_equal [], @repo.members
  end

  def test_all_returns_all_members
    item_1 = mock
    item_2 = mock
    expected = @repo.all

    assert_equal [item_1, item_2], expected
  end
end
