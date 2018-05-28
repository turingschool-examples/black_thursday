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
end
