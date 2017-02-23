require 'test_helper'

class RepoBuilderTest < Minitest::Test
  def setup
    se = SalesEngine.new
    rb = RepoBuilder.new(se)
  end
  def test_repo_builder_exists

  end
end
