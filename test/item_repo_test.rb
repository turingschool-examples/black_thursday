require_relative 'test_helper'
require_relative '../lib/item'
require_relative '../lib/item_repo'

class ItemRepoTest < Minitest::Test
    attr_reader :parent, :item_repo, :attrs
   
    def setup
        @attrs = {
            :id          => "263395721",
            :name        => "Disney scrabble frames",
            :description => "Disney glitter frames ...",
            :unit_price  => "1350",
            :merchant_id => "12334185",
            :created_at  => "2016-01-11 11:51:37 UTC",
            :updated_at  => "2008-04-02 13:48:57 UTC"}
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

    def test_it_can_find_item_by_name
        item = item_repo.find_by_name("Glitter scrabble frames")
        assert_equal "Glitter scrabble frames", item.name
    end

    def test_it_can_find_all_items_with_description
        description = "Free standing wooden letters"
        items = item_repo.find_all_with_description(description)

        items_array = items.map { |item| item.id }

        assert_equal [263396013, 263396011], items_array
    end

    def test_it_can_find_all_by_price
        price = "13.50"
        items = item_repo.find_all_with_price(price)

        items_array = items.map { |item| item.id }

        assert_equal [263395721, 263395729], items_array
    end

    def test_find_all_with_price_in_range
        price_range = Range.new(10, 30)
        items = item_repo.find_all_with_price_in_range(price_range)

        items_array = items.map { |item| item.id }

        assert_equal [263395237, 263395617, 
                      263395721, 263395239, 
                      263395619, 263395729], items_array
    end

    def test_it_finds_all_items_with_merchant_id
        merchant_id = 12334185
        items = item_repo.find_all_by_merchant_id(merchant_id)

        items_array = items.map { |item| item.id }

        assert_equal [263395617, 263395721, 
                      263396013, 263395619, 
                      263395729, 263396011], items_array
    end

    def test_it_finds_merchant_by_merchant_id
        merchant_id = 263395617
        parent.expect(:find_merchant_by_merchant_id, "merchant", [263395617])
        merchant = item_repo.find_merchant_by_merchant_id(merchant_id)
        assert_equal "merchant", merchant
    end

    def test_it_can_find_item_with_max_id
        max_id = item_repo.find_max_id
        assert_equal 263396013, max_id
    end

    def test_it_can_create_new_item
        new_item = item_repo.create(attrs)
        assert_instance_of Item, new_item
    end

    def test_it_can_update
        id = 263396013
        item = item_repo.find_by_id(id)

        assert_equal "Free standing Woden letters", item.name
        assert item.description.include?("Free standing wooden letters")
        assert_equal 7.00, item.unit_price

        item_repo.update(id, attrs)

        assert_equal "Disney scrabble frames", item.name
        assert item.description.include?("Disney glitter frames")
        assert_equal 13.50, item.unit_price
    end

    def test_it_can_delete
        id = 263396013
        item_to_delete = item_repo.find_by_id(id)

        assert item_repo.items.include?(item_to_delete)

        item_repo.delete(id)

        refute item_repo.items.include?(item_to_delete)
    end
end