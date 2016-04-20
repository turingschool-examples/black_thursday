require "minitest/autorun"
require "./lib/item_repo"
require "csv"


class ItemRepoTest < Minitest::Test

  def setup
    @repo = ItemRepo.new("./data/items.csv")
  end

  def test_repo_exists
    assert @repo
  end

  def test_if_items_array_created
    assert_equal Array, @repo.all.class
  end

  def test_that_we_loaded_item_objects
    assert Item, @repo.all[0].class
  end

  def test_it_finds_item_by_id
    assert_equal "510+ RealPush Icon Set", @repo.find_by_id("263395237").name
  end

  def test_it_finds_id_by_item_name
    assert_equal "263396255", @repo.find_by_name("Cache cache à la plage").id
  end

  def test_it_finds_all_items_by_name_fragment
    assert @repo.find_all_by_name("beautiful").any? do |item|
      item.name == "Hand-Made Beautiful Dragonfly"
    end
  end

  def test_it_finds_all_items_with_description_fragment
    assert @repo.find_all_with_description("batiks").any? do |item|
      item.description == "I love finding beautiful batiks"
      item.description == "100% Rayon Batik"
    end
  end

  def test_it_finds_item_name_by_unit_price
    assert @repo.find_all_by_price("15000").any? do |item|
      item.name == "Custom Hand Made Miniature Bicycle"
    end
  end

  def test_it_finds_items_in_price_range
    result = @repo.find_all_by_price_in_range(6.40, 6.75).map { |item| item.name}
    assert result.include?("Woodsy Sh!tz Spr!tz")
      # puts "Name: #{item.name} #{item.unit_price_to_dollars}"

    # assert @repo.find_all_by_price_in_range(500, 1000).any? do |item|
      # item.name == "Custom Hand Made Miniature Bicycle"
    # end
  end

  # @repo.all.each do |item|
  # puts item.name
  # end
  #
  # def test_print_merchant_id
  #   merchant_ids = @repo.all.map do |item|
  #     item.merchant_id
  #   end
  #
  #   grouping = merchant_ids.group_by do |thing|
  #     thing
  #   end
  #   puts grouping
  #   result = @repo.all.group_by do |item|
  #     item.merchant_id
  #   end
  #
  # end
  #
  def test_it_finds_all_items_by_merchant_id
    result = @repo.find_all_by_merchant_id("12336642").map do |item|
      item.name
    end
    assert result.include?("Picture Letters")
    assert result.include?("Wooden Picture Frames")
  end
end
