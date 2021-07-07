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
      updated_at: Time.now,
      merchant_id: 1231243
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

  def test_it_can_find_all_by_price
    assert_equal 41, @item_repository.find_all_by_price(12).count
  end

  def test_it_can_find_all_in_price_range
    assert_equal 70, @item_repository.find_all_by_price_in_range(12..14).count
  end

  def test_it_can_find_by_merchant_id
    assert_equal 10, @item_repository.find_all_by_merchant_id(12334951).count
  end

  def test_it_can_create_new_item
    assert_equal 263567474, @item_repository.repo.last.id

    @item_repository.create(@attributes)
    assert_equal 263567475, @item_repository.repo.last.id
  end

  def test_it_can_update
    new_attributes = {
      name: 'Black Pen',
      description: 'No lead, black ink',
      unit_price: BigDecimal(7.00, 4)
    }
    @item_repository.update(263395237, new_attributes)
    assert_equal 'Black Pen', @item_repository.find_by_id(263395237).name
    assert_equal 7, @item_repository.find_by_id(263395237).unit_price
    assert_equal 'No lead, black ink', @item_repository.find_by_id(263395237).description
  end

  def test_it_can_delete_by_id
    @item_repository.delete(263395237)
    assert_equal nil, @item_repository.find_by_id(263395237)
  end



end
