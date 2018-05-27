require './test/test_helper.rb'
require './lib/item_repository.rb'

class ItemRepositoryTest < Minitest::Test

  def test_it_exists
    ir = ItemRepository.new(["table", "chair", "desk"])
    assert_instance_of ItemRepository, ir
  end

  def test_it_makes_a_repository_of_items
    ir = ItemRepository.new(["table", "chair", "desk"])
    assert_equal 3, ir.repository.count
  end

end
