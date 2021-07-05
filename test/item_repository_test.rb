require './test/test_helper'
require './lib/item_repository'
require './lib/item'

class ItemRepositoryTest < Minitest::Test
  def test_it_exists
    ir = ItemRepository.new('./test/fixtures/item_fixture.csv', self)
    assert_instance_of ItemRepository, ir
  end

  def test_values
    ir = ItemRepository.new('./test/fixtures/item_fixture.csv', self)

    assert_equal 3, ir.all.count
    assert_instance_of Array, ir.all
    assert_instance_of Item, ir.all[0]
  end

  def test_find_by_id
    ir = ItemRepository.new('./test/fixtures/item_fixture.csv', self)

    assert_instance_of Item, ir.find_by_id('263399187')
    assert_equal 'Box', ir.find_by_id('263399187').name
  end

  def test_find_by_name
    ir = ItemRepository.new('./test/fixtures/item_fixture.csv', self)

    assert_instance_of Item, ir.find_by_name('Box')
    assert_equal '263399187', ir.find_by_name('Box').id
    assert_nil ir.find_by_name('Emmie')
  end

  def test_find_by_description
    ir = ItemRepository.new('./test/fixtures/item_fixture.csv', self)

    assert_instance_of Item, ir.find_all_with_description('Brown')[0]
    assert_instance_of Array, ir.find_all_with_description('Brown')
    assert_equal 'Box', ir.find_all_with_description('Brown')[0].name
    assert_equal [], ir.find_all_with_description('Emmie')
  end

  def test_find_all_by_price
    ir = ItemRepository.new('./test/fixtures/item_fixture.csv', self)

    assert_instance_of Item, ir.find_all_by_price('4800')[0]
    assert_instance_of Array, ir.find_all_by_price('4800')
    assert_equal 'Box', ir.find_all_by_price('4800')[0].name
    assert_equal [], ir.find_all_by_price('12')
  end

  def test_find_all_by_price_in_range
    ir = ItemRepository.new('./test/fixtures/item_fixture.csv', self)
    range = (10..9999)
    assert_instance_of Item, ir.find_all_by_price_in_range('4800')[0]
    assert_instance_of Array, ir.find_all_by_price_in_range('4800')
    assert_equal true, ir.find_all_by_price_in_range(4800.0)
  end

end
