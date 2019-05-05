require_relative 'test_helper'
require_relative '../lib/item'
require_relative '../lib/item_repo'

class ItemTest < Minitest::Test
    attr_reader :data,
                :parent,
                :item

  def setup
    @data = {
            :id          => "263395721",
            :name        => "Disney scrabble frames",
            :description => "Disney glitter frames ...",
            :unit_price  => "1350",
            :merchant_id => "12334185",
            :created_at  => "2016-01-11 11:51:37 UTC",
            :updated_at  => "2008-04-02 13:48:57 UTC"}
    @parent = Minitest::Mock.new
    @item = Item.new(data, parent)
  end
 
  def test_it_exists
    assert_instance_of Item, item
  end

  def test_item_takes_in_proper_values
    assert_equal 263395721, item.id
    assert_equal "Disney scrabble frames", item.name
    assert_equal "Disney glitter frames ...", item.description
    assert_equal BigDecimal.new("1350")/100, item.unit_price 
    assert_equal Time.parse("2016-01-11 11:51:37 UTC"), item.created_at
    assert_equal Time.parse("2008-04-02 13:48:57 UTC"), item.updated_at 
  end

  def test_item_has_correct_parent
    parent.expect(:class, ItemRepo)
    assert_equal ItemRepo, item.parent.class
  end

  def test_item_knows_its_merchant
    skip
  end
  
end