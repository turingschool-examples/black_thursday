require_relative './test_helper'
require_relative '../lib/repository'

class RepositoryTest < Minitest::Test

  def test_it_exists
    repo = Repository.new
    assert_instance_of Repository, repo
  end

  def test_data_starts_empty
    repo = Repository.new
    assert_equal [], repo.all
  end

  def test_it_inspects
    repo = Repository.new
    assert_equal '#<Repository 0 rows>', repo.inspect
  end
end
