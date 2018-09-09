require_relative 'test_helper'
require_relative '../lib/item.rb'

class ItemTest <  Minitest::Test
  def test_it_exists
    i = Item.new({
      :id     => 1,
      :name    => "Pencil",
      :description => "You can use it tow write things",
      :unit_price => BigDecimal.new(10.99,4),
      :created_at => Time.now,
      :updated_at => Time.now,
      :merchant_id => 2
      })
    assert_instance_of Item, i
  end

end
