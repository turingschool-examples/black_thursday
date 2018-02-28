require_relative 'test_helper'
require_relative '../lib/repository'

class TestRepository
  include Repository
end

class RepositoryTest < Minitest::Test
  def test_all
    dummy_repository = TestRepository.new
    dummy_repository.expects(:csv_items).returns([1, 2, 3])

    assert_equal [1, 2, 3], dummy_repository.all
  end

  def test_inspect
    dummy_repository = TestRepository.new
    dummy_repository.expects(:csv_items).returns([1, 2, 3])

    assert_equal "#<TestRepository 3 rows>", dummy_repository.inspect
  end

end
