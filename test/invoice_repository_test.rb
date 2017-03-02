require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/repository'
require_relative '../lib/sales_engine'
require_relative '../lib/invoice_repository'
require_relative '../test/file_hash_setup'

class InvoiceRepositoryTest < Minitest::Test

  attr_reader :file_hash, :se, :path, :repo, :invoice_repository

  include FileHashSetup

  def setup
    super
    @path = 'test/fixtures/invoice_sample.csv'
    @repo = Repository.new(se, path, Invoice)
    @invoice_repository = InvoiceRepository.new(se, path)
  end

  def test_it_finds_all_items
    assert_equal Array, invoice_repository.all.class
    refute_empty invoice_repository.all
  end

  def test_find_by_id
      assert_equal Invoice , invoice_repository.find_by_id(1).class
  end

  def test_it_finds_items_by_id_number
    invoice = se.invoices.find_by_id(20)
    assert_equal Array, invoice.items.class
  end

  def test_find_all_by_customer_id
    assert_equal Array, invoice_repository.find_all_by_customer_id(1).class
  end

  def test_find_all_by_merchant_id
    assert_equal Array, invoice_repository.find_all_by_merchant_id(12335938).class
  end

  def test_find_all_by_status
    assert_equal Array, invoice_repository.find_all_by_status("shipped").class
  end

  def test_it_finds_all_by_date
    date = Time.parse("2009-02-07")
    assert_equal  Array, invoice_repository.find_all_by_date(date).class
    refute_empty invoice_repository.find_all_by_date(date)
  end
end
