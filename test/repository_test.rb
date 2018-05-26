require './lib/repository'
require 'minitest/autorun'
require 'minitest/pride'

class RepositoryTest < Minitest::Test
  def test_it_exists
    repository = Repository.new

    assert_instance_of Repository, repository
  end
end
