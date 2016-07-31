gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative "../lib/invoice_item_repository"
require_relative "../lib/sales_engine"
require 'csv'


class InvoiceItemRepositoryTest < MiniTest::Test
  attr_reader :invoice_item_repository

  def setup
    # @se = SalesEngine.from_csv({
    #                              :items     => "./data/items.csv",
    #                              :merchants => "./data/merchants.csv",
    #                             })
    @invoice_item_repository = InvoiceItemRepository.new("./data/invoice_items.csv")
  end

  def test_it_maker_polulates_all_with_instances_of_item
    assert_instance_of InvoiceItem, invoice_item_repository.all.first
    assert_equal 998, invoice_item_repository.all.length
  end

  def test_empty_id_returns_nil #sad test
    assert_equal nil, invoice_item_repository.find_by_id("not_a_valid_id")
    assert_equal nil, invoice_item_repository.find_by_id(99999999)
  end
#
  def test_it_finds_by_id
    assert_instance_of InvoiceItem, invoice_item_repository.find_by_id(1)
    assert_equal 263519844, invoice_item_repository.find_by_id(1).item_id
  end

  def test_it_finds_all_by_invoice_id_is_invalid
    assert_equal [], invoice_item_repository.find_all_by_item_id(9999999)
  end

  def test_it_finds_all_by_item_id
    assert_instance_of InvoiceItem, invoice_item_repository.find_all_by_item_id(263519844).first
    assert_equal 1, invoice_item_repository.find_all_by_item_id(263519844).length
    assert_equal 1, invoice_item_repository.find_all_by_item_id(263519844).first.invoice_id
  end

  def test_it_finds_all_by_invoice_id_is_invalid
    assert_equal [], invoice_item_repository.find_all_by_invoice_id(9999999)
  end

  def test_it_finds_all_by_invoice_id
    assert_instance_of InvoiceItem, invoice_item_repository.find_all_by_invoice_id(1).first
    assert_equal 8, invoice_item_repository.find_all_by_invoice_id(1).length
    assert_equal 263519844, invoice_item_repository.find_all_by_invoice_id(1).first.item_id
  end

#   def test_it_can_tell_you_which_merchant_sells_it
#     assert_instance_of Merchant, @se.items.find_by_id(263395237).merchant
#   end
#
#   def test_item_count
#     assert_equal 9, @se.items.all.count
#   end
#
end
