require_relative 'test_helper'
require './lib/items_repository'
require 'csv'

class ItemsRepositoryTest < Minitest::Test
  def setup
    items = CSV.open './data/test_items.csv',
                      headers: true,
                      header_converters: :symbol
    @ir = ItemsRepository.new(items)
  end

  def test_items_repo_exists
    assert_instance_of ItemsRepository, @ir
  end

  def test_it_initializes_empty
    assert_equal [], @ir.items
  end

  def test_it_can_load_items
    csv = @ir.items_csv
    @ir.load_items(csv)

    assert_equal 5, @ir.items.length
  end
end
