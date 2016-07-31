gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative "../lib/invoice_repository"
require_relative "../lib/sales_engine"
require 'csv'


class InvoiceRepositoryTest < MiniTest::Test
  attr_reader :invoice_repository

  def setup
    # @se = SalesEngine.from_csv({
    #                              :items     => "./data/items.csv",
    #                              :merchants => "./data/merchants.csv",
    #                             })
    @invoice_repository = InvoiceRepository.new("./data/invoices.csv")
  end

  def test_invoice_maker
    assert_equal 3, invoice_repository.all[2].id
    assert_equal "shipped", invoice_repository.all[2].status
  end

  def test_it_returns_all_the_invoice_instances
    assert_equal 1, invoice_repository.all.first.id
    assert_equal 19, invoice_repository.all.last.id
  end

  def test_it_finds_by_id
    assert_equal 12335955, invoice_repository.find_by_id(3).merchant_id
  end

  def test_it_returns_nil_if_id_does_not_exist
    assert_equal nil, invoice_repository.find_by_id(3423424)
  end

  def test_find_all_by_customer_id
    assert_equal 8, invoice_repository.find_all_by_customer_id(1).length
  end

  def test_returns_empty_array_if_no_customer_id_matches
    assert_equal [], invoice_repository.find_all_by_customer_id(883773)
  end

  def test_it_finds_all_by_merchant_id
    assert_equal 2, invoice_repository.find_all_by_merchant_id(12335955).length
  end

  def test_it_returns_empty_array_if_no_merchant_id_matches
    assert_equal [], invoice_repository.find_all_by_merchant_id(12345678)
  end

  def test_it_finds_all_by_status
    assert_equal 9, invoice_repository.find_all_by_status("pending").length
  end

  def test_it_returns_empty_array_if_no_statses_match
    assert_equal [], invoice_repository.find_all_by_status("hurry")
  end

end
