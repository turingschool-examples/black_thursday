require './test/minitest_helper'
require './lib/item_repository'
require 'CSV'

class MerchantTest<Minitest::Test

  def setup
    @ir = ItemRepository.new('./test/fixtures/items_fixtures.csv')
  end

  def test_it_exists
    assert_instance_of ItemRepository, @ir
  end

  def test_item_repo_has_items
    assert_equal 10 , @ir.all.count
    assert_instance_of Array, @ir.all
  end

  def test_it_can_find_item_by_id
    result = @ir.find_by_id(263397059)

    assert_instance_of Item, result
    assert_equal 263397059, result.id
    assert_equal "Etre ailleurs", result.name
  end

  def test_it_can_find_items_by_name
    result = @mr.find_by_name("Etre ailleurs")
    assert_equal "Etre ailleurs", result.name
  end

  # def test_it_can_find_all_by_name
  #   result = @mr.find_all_by_name("Urcase")
  #   assert_equal "Urcase", result.find_all_by_name(name)
  # end

end
