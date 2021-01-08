require './test/test_helper'

class ItemTest < Minitest::Test

def setup
  @i = Item.new({
  :id          => 1,
  :name        => "Pencil",
  :description => "You can use it to write things",
  :unit_price  => BigDecimal.new(10.99,4),
  :created_at  => Time.now,
  :updated_at  => Time.now,
  :merchant_id => 2
  })
end

  def test_it_exists
    assert_instance_of Item, @i
  end

  def test_it_has_attributes
    assert_equal  1, @i.id
    assert_equal "Pencil", @i.name
    assert_equal "You can use it to write things", @i.description
    assert_equal 2, @i.merchant_id.to_i
    # assert_equal BigDecimal.new(10.99,4), @i.unit_price
    # assert_equal Time.now, @i.created_at
    # assert_operator Time.now, :<, @i.description
    # assert_equal  , @i.unit_price_to_dollars
  end
end



# context "Item" do
#   it "#id returns the id" do
#     item_one = engine.items.all.first
#     expect(item_one.id).to eq 263395237
#
#     item_two = engine.items.all.last
#     expect(item_two.id).to eq 263567474
#   end
#
#   it "#name returns the name" do
#     item_one = engine.items.all.first
#     expect(item_one.name).to eq "510+ RealPush Icon Set"
#
#     item_two = engine.items.all.last
#     expect(item_two.name).to eq "Minty Green Knit Crochet Infinity Scarf"
#   end
#
#   it "#description returns the description" do
#     item_one = engine.items.all.first
#
#     expect(item_one.description.class).to eq String
#     expect(item_one.description.length).to eq 2236
#   end
#
#   it "#unit_price returns the unit price" do
#     item_one = engine.items.all.first
#
#     expect(item_one.unit_price).to eq 12.00
#     expect(item_one.unit_price.class).to eq BigDecimal
#   end
#
#   it "#created_at returns the Time the item was created" do
#     item_one = engine.items.all.first
#
#     expect(item_one.created_at).to eq Time.parse("2016-01-11 09:34:06 UTC")
#     expect(item_one.created_at.class).to eq Time
#   end
# #
#   it "#updated_at returns the Time the item was last updated" do
#     item_one = engine.items.all.first
#
#     expect(item_one.updated_at).to eq Time.parse("2007-06-04 21:35:10 UTC")
#     expect(item_one.updated_at.class).to eq Time
#   end

#   it "#unit_price_to_dollars returns price as Float" do
#     expected = engine.items.find_by_id(263397059)
#     expect(expected.unit_price_to_dollars).to eq 130.0
#     expect(expected.unit_price_to_dollars.class).to eq Float
#   end
