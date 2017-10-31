require_relative 'test_helper'

class ItemRepositoryTest < MiniTest::Test

  def test_it_exists
    ir = ItemRepository.new

    assert_instance_of ItemRepository, ir
  end

  

end
