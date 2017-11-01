require_relative 'test_helper'
require 'csv'
require_relative './../lib/merchant'
require_relative './../lib/merchant_repository'
require_relative './../lib/sales_engine'

class MerchantRepositoryTest < Minitest::Test
  attr_reader :repository,
              :engine

  def setup
    @engine = SalesEngine.from_csv(
      items: "./test/fixtures/truncated_items.csv",
      merchants: "./test/fixtures/truncated_merchants.csv"
    )

    @repository = MerchantRepository.new("./test/fixtures/truncated_merchants.csv", engine)
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @repository
  end

  def test_it_can_return_all_merchants
    assert_equal repository.merchants, @repository.all
    assert_equal 60, repository.all.length
  end

  def test_it_can_find_merchant_by_id
    assert_equal Merchant, repository.find_by_id(12334113).class
    assert_equal "MiniatureBikez", repository.find_by_id(12334113).name
    assert_instance_of Time, repository.find_by_id(12334113).created_at
  end

  def test_find_by_id_edge_case
    assert_nil repository.find_by_id(67869584684)
    assert_nil repository.find_by_id("smush")
    assert_nil repository.find_by_id("12334113")
    assert_nil repository.find_by_id(nil)
  end

  def test_find_by_name_returns_first_merchant_with_matching_name
    assert_equal Merchant, repository.find_by_name("MiniatureBikez").class
    assert_equal "MiniatureBikez", repository.find_by_name("MiniatureBikez").name
    assert_equal 12334113, repository.find_by_name("MiniatureBikez").id
  end

  def test_find_by_name_edge_case
    assert_nil repository.find_by_name(67869584684)
    assert_nil repository.find_by_name("smush")
    assert_nil repository.find_by_name("12334113")
    assert_nil repository.find_by_name(nil)
  end

  def test_find_all_by_name_returns_all_matches_of_the_name_fragment
    assert_equal Array, repository.find_all_by_name("wood").class
    assert_equal 3, repository.find_all_by_name("wood").length
    assert_equal "Corbeilwood", repository.find_all_by_name("wood").first.name
    assert_equal "MacDonaldWoodworks", repository.find_all_by_name("wood").last.name
    assert_equal 12334246, repository.find_all_by_name("wood").first.id
    assert_equal 12336411, repository.find_all_by_name("wood").last.id
  end

  def test_find_all_by_name_edge_case
    assert_equal [], repository.find_all_by_name("smush")
    assert_equal [], repository.find_all_by_name(nil)
    assert_equal [], repository.find_all_by_name("mike dao's twitter feed")
  end

  def test_inspect
    assert_equal "MerchantRepository has 60 rows", repository.inspect
  end
end
