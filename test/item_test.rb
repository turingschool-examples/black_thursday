require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require './lib/cleaner'
# refactor to mock/stubs to avoid redundancy?
# But in the update test we do need to check on a real item i think?
require './lib/item_repo'


class ItemTest < Minitest::Test
  def setup
    @item = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99, 4),
      :created_at  => 10,
      :updated_at  => 12,
      :merchant_id => 2
      })
      @cleaner = Cleaner.new # refactor out?
  end

  def test_it_exists_with_attributes
    assert_instance_of Item, @item
    assert_equal 1, @item.id
    assert_equal "Pencil", @item.name
    assert_equal "You can use it to write things", @item.description
    assert_equal 0.1099e2, @item.unit_price
    assert_equal 10, @item.created_at
    assert_equal 12, @item.updated_at
    assert_equal 2, @item.merchant_id
  end

  def test_unit_price_to_dollars
    assert_equal 0.11, @item.unit_price_to_dollars
  end

  def test_update
    ir = ItemRepository.new

    attributes = {
      name: "Capita Defenders of Awesome 2018",
      description: "This board both rips and shreds",
      unit_price: BigDecimal.new(399.99, 5),
      created_at: Time.now,
      updated_at: Time.now,
      merchant_id: 25
    }
    updated_attribute_hash = {
      :name => "Bleeps",
      :description => "doop doop doop",
      :unit_price => BigDecimal.new(599.99, 5)
    }
    # updated_time = mock()
    # updated_time.stubs(:updated_at).returns(2021-01-07 18:03:23 -0700)
    # allow(Time).to receive(:now).and_return(@time_now)
    # Time.stubs(:now).returns(Time.mktime(1970,1,1))
    ir.create(attributes)
    target_item = ir.find_item_by_id(263567475)[0]
    require "pry"; binding.pry
    target_item.update(263567475, updated_attribute_hash)
    assert_equal 263567475, ir.find_by_name("Bleeps").id
  end

end
