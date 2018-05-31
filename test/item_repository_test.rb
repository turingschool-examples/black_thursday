require_relative 'test_helper'
require './lib/sales_engine'
require './lib/item_repository'
require './lib/item'

class ItemsRepositoryTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
      :items     => './data/items.csv',
      :merchants => './data/merchants.csv'
    })
    @item_repository = @se.items
  end

  def test_it_exists
    assert_instance_of ItemRepository, @item_repository
  end

  def test_item_repo_holds_all_instances_of_items
    assert_equal 1367, @item_repository.all.length
  end

  def test_all_returns_array_of_all_item_objects
    items = @item_repository.all
    assert items.all? do |item|
      item.class == Item
    end
  end

  def test_find_by_id_returns_items_with_given_id
    items = @item_repository.all
    refute @item_repository.find_by_id('notarealid')
    assert_instance_of Item, @item_repository.find_by_id(263395237)
    assert_equal 263395237, @item_repository.find_by_id(263395237).id

    result = '510+ RealPush Icon Set'
    assert_equal result, @item_repository.find_by_id(263395237).name
  end

  def test_find_by_name_returns_item_object_with_given_name
    refute @item_repository.find_by_name('notarealname')
    result = '510+ RealPush Icon Set'
    assert_instance_of Item, @item_repository.find_by_name('510+ RealPush Icon Set')
    assert_equal 263395237, @item_repository.find_by_name('510+ RealPush Icon Set').id
    assert_equal result, @item_repository.find_by_name('510+ RealPush Icon Set').name
  end

  def test_find_all_by_name_fragment
    assert_instance_of Array, @item_repository.find_all_by_name('art')
    assert_equal 73, @item_repository.find_all_by_name('art').length
    assert_equal [], @item_repository.find_all_by_name('asdgihweogdv')
  end

  def test_it_can_create_a_new_item_object
    refute @item_repository.find_by_id(263567475)
    @item_repository.create({name: 'test_item',
                            description: 'this is a test item',
                            unit_price: '1200',
                            merchant_id: '456782345',
                            created_at: Time.now,
                            updated_at: Time.now})
    assert_equal 'test_item', @item_repository.find_by_id(263567475).name
  end

  def test_it_can_update_item_name
    @item_repository.create({name: 'test_item',
                            description: 'this is a test item',
                            unit_price: '1200',
                            merchant_id: '456782345',
                            created_at: Time.now,
                            updated_at: Time.now})
    assert @item_repository.find_by_name('test_item')
    refute @item_repository.find_by_name('test_item_new')

    @item_repository.update(263567475,{name: 'test_item_new',
                                        description: 'This is a test.',
                                        unit_price: BigDecimal.new(500.01, 5),
                                        created_at: Time.now,
                                        updated_at: Time.now,
                                        merchant_id: 100} )

    refute @item_repository.find_by_name('test_item')
    assert @item_repository.find_by_name('test_item_new')
  end

  def test_it_can_delete_a_item_object
    assert @item_repository.find_by_id(263567474)
    @item_repository.delete(263567474)
    refute @item_repository.find_by_id(263567474)
  end
end
