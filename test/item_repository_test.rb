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
    assert_equal 1367, @item_repository.repo.count
  end

  def test_it_can_return_all
    assert_equal @item_repository.repo, @item_repository.all
  end

  def test_it_can_find_by_id
    assert_equal @item_repository.repo[0], @item_repository.find_by_id(263395237)
  end

  def test_it_can_find_by_name
    assert_equal @item_repository.repo[0], @item_repository.find_by_name("510+ RealPush Icon Set")

  end

  def test_it_can_find_by_item_description
    assert_equal [@item_repository.repo[0]], @item_repository.find_all_with_description("Almost every social icon")
    assert_equal [], @item_repository.find_all_with_description("saxophone")

  end



end
