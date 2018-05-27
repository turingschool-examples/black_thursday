require_relative 'test_helper'

class ItemsRepositoryTest < Minitest::Test
  def test_it_exists
      ir = ItemsRepository.new
      assert_instance_of ItemsRepository, ir
  end
end
