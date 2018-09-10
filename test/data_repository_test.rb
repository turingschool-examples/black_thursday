require_relative 'test_helper'
require_relative '../lib/data_repository'
require_relative '../lib/item'

class DataRepositoryTest < Minitest::Test
  def setup
    @time_1 = '1993-10-28 11:56:40 UTC'

    @time_2 = '1993-09-29 12:45:30 UTC'

    @raw_data = [{id:          '123',
                  name:        'testname',
                  description: 'fakedescription',
                  merchant_id: '456',
                  unit_price:  '1200',
                  created_at:  @time_1,
                  updated_at:  @time_2},
                 {id:          '321',
                  name:        'secondname',
                  description: 'describedagain',
                  merchant_id: '654',
                  unit_price:  '2100',
                  created_at:  @time_2,
                  updated_at:  @time_1}]

    @repo = DataRepository.new(@raw_data, Item)
  end

  def test_it_exists_and_populates_objects_from_data
    assert_instance_of(DataRepository, @repo)
    all_items = @repo.all
    assert_instance_of(Array, all_items)
    assert(all_items.all? {|item| item.class == Item})
    assert_equal(321, all_items[1].id)
  end

  def test_it_can_find_object_by_id
    actual = @repo.find_by_id(123)
    assert_instance_of(Item, actual)
    assert_equal('testname', actual.name)
  end

  def test_it_can_find_object_by_name
    actual = @repo.find_by_name('Secondname')
    actual_2 = @repo.find_by_name('sadpath')
    assert_instance_of(Item, actual)
    assert_nil(actual_2)
    assert_equal(321, actual.id)
  end

  def test_it_can_validate_new_object_from_attributes
    skip
  end

  def test_it_can_create_new_object_from_attributes
    skip
  end

  def test_it_can_update_new_object_by_id_and_attributes
    skip
  end
end
