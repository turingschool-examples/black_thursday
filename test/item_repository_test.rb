require './test/test_helper'
require './lib/item_repository'
require './lib/item'
require 'csv'

class ItemRepositoryTest < Minitest::Test
  attr_reader :ir

  def setup
    items_file = CSV.open("./test/testdata/items_single.csv",
                          headers:true,
                          header_converters: :symbol)
    csv_rows = items_file.map { |row| row }
    @ir = ItemRepository.new(csv_rows)
  end

  def test_item_is_instantiated_with_correct_attributes
    assert_equal 263415243, ir.items[0].id
    assert_equal "Davido Gracia Genuine Python tote" , ir.items[0].name
    assert_equal "Beautiful genuine Python tote", ir.items[0].description
    assert_equal 120.99, ir.items[0].unit_price
    assert_equal 12334155, ir.items[0].merchant_id
    assert_equal Time.parse('2016-01-11 15:11:05 UTC'), ir.items[0].created_at
    assert_equal Time.parse('2003-02-19 16:49:05 UTC'), ir.items[0].updated_at
  end

  def test_method_all_returns_known_item_instances
    assert_equal true, ir.all.all? {|x| x.class == Item}
  end

end
