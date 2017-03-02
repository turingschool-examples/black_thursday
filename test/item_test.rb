require './test/test_helper.rb'

class ItemTest < Minitest::Test
  attr_reader :item

  def setup
    @item =  Item.new({
      :name        => "Pencil",
      :description => "write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => "2012-03-27 14:54:09 UTC",
      :updated_at  => "2012-03-27 14:54:09 UTC"},
      parent = ""
    )
  end

  def test_it_exists
    assert_instance_of Item, item
  end

  def test_it_has_a_name
    assert_equal "Pencil", item.name
  end

  def test_it_describes
    assert_equal "write things", item.description
  end

  def test_it_creates_at_time
    assert_instance_of Time, item.created_at
  end

  def test_it_updates_at_time
    assert_instance_of Time, item.updated_at
  end

end
