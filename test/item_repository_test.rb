require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repository.rb'
require './test/test_helper.rb'
require 'csv'

class ItemRepositoryTest < Minitest::Test
  def setup
    @item_csv = CSV.open './test/fixtures/items.csv', headers: true, header_converters: :symbol
    @parent = ""
  end
  
  def test_it_exists
    assert_instance_of ItemRepository, ItemRepository.new(1, 2)
  end

  def test_all_array
    repo = ItemRepository.new(@item_csv, @parent)
    repo.make_repository
    assert_equal [], repo.all
  end


end