require_relative 'test_helper'
require './lib/sales_engine'
require 'csv'

class MerchantRepositoryTest < Minitest::Test

  def setup
    item_file_path = './test/fixtures/items_truncated.csv'
    merchant_file_path = './test/fixtures/merchants_truncated.csv'
    invoice_file_path = './test/fixtures/invoices_truncated.csv'
    engine = SalesEngine.new(item_file_path, merchant_file_path, invoice_file_path)
    @repository = engine.merchants
  end

  def test_merchant_repository_class_exists
    assert_instance_of MerchantRepository, @repository
  end

  def test_load_from_csv_returns_array_of_merchants
    assert_instance_of Merchant, @repository.merchants[0]
  end

  def test_all_returns_array_of_all_merchants
    all_merchants = @repository.all
    assert_equal 4, all_merchants.count
  end

  def test_it_finds_merchant_by_id
    merchant = @repository.find_by_id(12334113)

    assert_equal "MiniatureBikez", merchant.name

    merchant = @repository.find_by_id('12334113')

    assert_equal "MiniatureBikez", merchant.name
  end

  def test_it_finds_merchants_by_name
    merchant = @repository.find_by_name("LolaMarleys")

    assert_equal 12334115, merchant.id

    merchant = @repository.find_by_name("lolamarleys")

    assert_equal 12334115, merchant.id
  end

  def test_it_returns_empty_array_if_no_name_foun
    assert_empty(@repository.find_all_by_name("xyz"))
  end

  def test_it_finds_all_merchants_by_name_fragments
    merchants = @repository.find_all_by_name("ar")
    merchant1 = @repository.find_by_name("Candisart")
    merchant2 = @repository.find_by_name("LolaMarleys")

    assert merchants.include?(merchant1)
    assert merchants.include?(merchant2)
  end

end
