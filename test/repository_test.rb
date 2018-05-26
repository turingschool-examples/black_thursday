require './test/test_helper'
require './lib/repository'

class RepositoryTest < Minitest::Test
  def test_it_exists
    repository = Repository.new

    assert_instance_of Repository, repository
  end
end
