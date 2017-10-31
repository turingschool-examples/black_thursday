require_relative 'test_helper'
require './lib/item_repository'
require 'pry'
require 'csv'
require 'date'
class ItemRepositoryTest < Minitest:: Test

  def test_it_creates_item

    ir = ItemRepository.new("")
    # assert_equal 0, ir.count
    ir.create_item( {:id => 1,
                :name => "toys",
                :description => "fuzzy",
                :unit_price => 333,
                :created_at  => Date.today,
                :updated_at => Date.today,
                :unit_price_to_dollars => 3.33,
                :merchant_id => 24})
    # ir.create_item(:name=>"Sample 2")
    assert_equal "toys", ir.items_store[0].name
    # assert_equal "Sample 2", ir.items[1].name
  end
end
