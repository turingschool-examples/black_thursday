require_relative './../lib/merchant_repository'
require_relative './../lib/item_repository'
require_relative '../lib/sales_engine'
require_relative '../lib/load_data'
require_relative 'spec_helper'
require          'pry'
require          'minitest/autorun'
require          'minitest/pride'


class MerchantRepositoryTest < Minitest::Test
  include LoadData

  def load_csv(csv_filepath)
    repo_rows = csv_filepath.map do |type, filename|
      [type, LoadData.load_data(filename)]
    end.to_h
  end

  def test_that_class_exist
    assert MerchantRepository
  end

  def test_that_all_method_exist
    assert MerchantRepository.method_defined? :all
  end

  def test_that_find_by_id_method_exist
    assert MerchantRepository.method_defined? :find_by_id
  end

  def test_that_find_by_name_method_exist
    assert MerchantRepository.method_defined? :find_by_name
  end

  def test_that_all_by_name_method_exist
    assert MerchantRepository.method_defined? :find_all_by_name
  end

  def test_that_all_method_returns_an_array
    merchant_repo = MerchantRepository.new(
                    [
                      {id: "122", name: "11860"},
                      {id: "134", name: "10990"},
                      {id: "345", name: "10"},
                      {id: "457", name: "10"},
                    ], items_repo)

    assert_kind_of(Array, merchant_repo.all)
  end

  def test_that_the_all_method_returns_the_four_sample_merchant_stores_info
    repo = MerchantRepository.new([
        {id: 1, name: "11860"},
        {id: 2, name: "10990"},
        {id: 3, name: "10"},
        {id: 4, name: "10"},
      ])

    assert_equal 4, repo.all.count
  end
  def test_that_find_by_name_method_is_an_instance_of_merchant
    repo = MerchantRepository.new([
        {id: 1, name: "MiniatureBikez"},
        {id: 2, name: "10990"},
        {id: 3, name: "10"},
        {id: 4, name: "10"},
      ])

    assert_equal Merchant, repo.find_by_name("MiniatureBikez").class
  end

  def test_that_find_by_name_returns_a_known_merchant_name
    repo = MerchantRepository.new([
        {id: 1, name: "MiniatureBikez"},
        {id: 2, name: "10990"},
        {id: 3, name: "10"},
        {id: 4, name: "10"},
      ])

    merchant = repo.find_by_name("MiniatureBikez")

    assert_equal "MiniatureBikez", merchant.name
  end

  def test_edge_that_find_by_name_works_when_spaces_are_included
    repo = MerchantRepository.new([
        {id: 1, name: "MiniatureBikez"},
        {id: 2, name: "10990"},
        {id: 3, name: "10"},
        {id: 4, name: "10"},
      ])

    merchant = repo.find_by_name("Miniature Bikez")

    assert_equal "MiniatureBikez", merchant.name
  end

  def test_edge_that_find_by_name_works_when_not_case_sensitive
    repo = MerchantRepository.new([
        {id: 1, name: "MiniatureBikez"},
        {id: 2, name: "10990"},
        {id: 3, name: "10"},
        {id: 4, name: "10"},
      ])

    merchant = repo.find_by_name("mInIaTuRebIKez")

    assert_equal "MiniatureBikez", merchant.name
  end

  def test_edge_that_find_by_name_returns_nil_for_unknown_merchant_name
    repo = MerchantRepository.new([
        {id: 1, name: "MiniatureBikez"},
        {id: 2, name: "10990"},
        {id: 3, name: "10"},
        {id: 4, name: "10"},
      ])
    merchant = repo.find_by_name("Turing School")

    assert_equal nil, merchant
  end

  def test_that_find_by_id_returns_known_id
    repo = MerchantRepository.new([
        {id: 1, name: "MiniatureBikez"},
        {id: 2, name: "10990"},
        {id: 3, name: "10"},
        {id: 4, name: "10"},
      ])

    merchant = repo.find_by_id(4)

    assert_equal 4, merchant.id
  end

  def test_that_find_by_id_returns_nil_for_unknown_id
    repo = MerchantRepository.new([
        {id: 1, name: "MiniatureBikez"},
        {id: 2, name: "10990"},
        {id: 3, name: "10"},
        {id: 4, name: "10"},
      ])

    merchant = repo.find_by_id(000023412)

    assert_equal nil, merchant
  end

  def test_that_find_by_id_with_input_as_a_string_works
    repo = MerchantRepository.new([
        {id: 1, name: "MiniatureBikez"},
        {id: 2, name: "10990"},
        {id: 3, name: "10"},
        {id: 10, name: "10"},
      ])

    merchant = repo.find_by_id("10")

    assert_equal 10, merchant.id
  end

  def test_that_find_all_by_name_returns_known_merchant_with_fragment_input
    repo = MerchantRepository.new([
        {:id=>"12334105", :name=>"Shopin1901", :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"},
        {:id=>"12334112", :name=>"Candisart", :created_at=>"2016-01-11 14:23:09 UTC", :updated_at=>"2016-01-11 14:23:09 UTC"},
        {:id=>"12334113", :name=>"MiniatureBikez", :created_at=>"2016-01-11 11:33:39 UTC", :updated_at=>"2016-01-11 18:30:35 UTC"},
        {:id=>"12334342", :name=>"Shopinmini", :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"},
        {:id=>"12334452", :name=>"heyMiniWheels", :created_at=>"2016-01-11 14:23:09 UTC", :updated_at=>"2016-01-11 14:23:09 UTC"},
        {:id=>"12332423", :name=>"MiniatureTights", :created_at=>"2016-01-11 11:33:39 UTC", :updated_at=>"2016-01-11 18:30:35 UTC"},
     ])

    assert_equal ["MiniatureBikez","Shopinmini", "heyMiniWheels", "MiniatureTights"], repo.find_all_by_name("Mini").map(&:name)
  end

  def test_that_find_all_by_name_returns_empty_array_for_unknown_merchant
    repo = MerchantRepository.new([
        {:id=>"12334105", :name=>"Shopin1901", :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"},
        {:id=>"12334112", :name=>"Candisart", :created_at=>"2016-01-11 14:23:09 UTC", :updated_at=>"2016-01-11 14:23:09 UTC"},
        {:id=>"12334113", :name=>"MiniatureBikez", :created_at=>"2016-01-11 11:33:39 UTC", :updated_at=>"2016-01-11 18:30:35 UTC"},
        {:id=>"12334342", :name=>"Shopinmini", :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"},
        {:id=>"12334452", :name=>"heyMiniWheels", :created_at=>"2016-01-11 14:23:09 UTC", :updated_at=>"2016-01-11 14:23:09 UTC"},
        {:id=>"12332423", :name=>"MiniatureTights", :created_at=>"2016-01-11 11:33:39 UTC", :updated_at=>"2016-01-11 18:30:35 UTC"},
     ])

    assert_equal [], repo.find_all_by_name("Candy").map(&:name)
  end

end

# se = SalesEngine.from_csv({
#                           :merchants => "./data/merchant_sample.csv",
#                           })
# class SalesEngine
#   attr_reader :repo_rows, :items, :merchants
#
#   def initialize(repo_rows)
#     @repo_rows            = repo_rows
#     @items                = ItemRepository.new(repo_rows[:items])
#     @merchants            = MerchantRepository.new(repo_rows[:merchants], @items)
#   end
#
#   def self.from_csv(csv_hash)
#     repo_rows = csv_hash.map do |type, filename|
#       [type, LoadData.load_data(filename)]
#     end.to_h
#
#     SalesEngine.new(repo_rows)
        # HERE IS WHERE THE PROBLEM WILL BEGIN
        #Since it'll go to the top w/o anything to add to the items class
#   end
#
# end

# ===================================================================>>>>>
#we cannot have tests like this in here because our
#sales engine class when using this method needes to initialize
#both the item repo and merchant repo, if any of the two are missing it
#will input nil for when loading up @items and @merchants, therefore
#we need to use the shortcut way like so
# <<<<====================================================================

# =============================================
#    repo = MerchantRepository.new([
      #   {id: 1, name: "MiniatureBikez"},
      #   {id: 2, name: "10990"},
      #   {id: 3, name: "10"},
      #   {id: 10, name: "10"},
      # ])
# =============================================
