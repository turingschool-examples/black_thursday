require './test/test_helper.rb'
require './lib/item_repository.rb'
require './lib/file_loader.rb'


class ItemRepositoryTest < Minitest::Test
  include FileLoader

  def setup
    @item_repository = ItemRepository.new(load_file('./data/items.csv'))
    @attributes = {
      name: 'Pencil',
      description: 'You can use it to write things',
      unit_price: BigDecimal(10.99, 4),
      created_at: Time.now,
      updated_at: Time.now
    }

  end

  def test_it_exists
    assert_instance_of ItemRepository, @item_repository
  end

  def test_it_can_make_repo_of_item
    assert_equal 1367, @item_repository.item_repo.count
  end




end
