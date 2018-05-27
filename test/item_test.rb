require_relative 'test_helper.rb'
require_relative '../lib/salesengine.rb'
require_relative '../lib/merchantrepository'
require_relative '../lib/merchant'
require_relative '../lib/item_repository.rb'
require_relative '../lib/item'
require 'minitest/autorun'
require 'minitest/pride'
require 'csv'
class ItemTest < Minitest::Test
  def test_it_exists
    i = Item.new({
      :id          => '12336623'
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now
                })
    assert_instance_of Item, i
  end
end
