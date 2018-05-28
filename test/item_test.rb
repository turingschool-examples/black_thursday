require './test/test_helper.rb'
require './lib/item.rb'

class ItemTest < Minitest::Test

  def test_it_exists
    i = Item.new({
        :id          => "123456",
        :name        => "Pencil",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal.new(10.99,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
    })
    assert_instance_of Item, i
  end

  def test_you_can_access_specifications
    i = Item.new({
        :id          => "123456",
        :name        => "Pencil",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal.new(10.99,4),
        :created_at  => 600,
        :updated_at  => 600,
    })
    # assert_equal 123456, i.id
    assert_equal "Pencil", i.name
    assert_equal "You can use it to write things", i.description
    assert_equal 10.99, i.unit_price
    assert_equal "600", i.created_at
    assert_equal "600", i.updated_at
  end

end
