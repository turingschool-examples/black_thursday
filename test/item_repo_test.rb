require_relative 'test_helper'
require_relative '../lib/item'
require_relative '../lib/item_repo'

class ItemRepoTest < Minitest::Test
    attr_reader :parent, :item_repo
   
    def setup
        data = LoadFile.load('./test/fixture_data/item_repo_fixture.csv')
        @parent = Minitest::Mock.new
        @item_repo = ItemRepo.new(data, parent)
    end

    def test_it_exists
        assert_instance_of ItemRepo, @item_repo
    end

    def test_it_returns_array_of_all_items_of_repository
        assert_instance_of Array, @item_repo.all
        assert_equal 8, @item_repo.all.length
    end

    def test_it_can_find_item_by_id
        item = item_repo.find_by_id(263396013)
        assert_equal 263396013, item.id
    end
end