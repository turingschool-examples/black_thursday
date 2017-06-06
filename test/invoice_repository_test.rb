require 'csv'
require_relative 'test_helper'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test

  attr_reader :invoice

  def setup
    @invoice = InvoiceRepository.new({
  :items => "./data/items.csv",
  :merchants => "./data/merchants.csv",
  :invoices => "./test/data/invoices_truncated.csv"
  }, self)
  end

  def test_it_exists
    actual = @invoice.class
    expected = InvoiceRepository

    assert_equal expected, actual
  end

  def test_item_repo_opens_csv_into_array
    actual   = @invoice.all_invoice_data.class
    expected = Array

    assert_equal expected, actual
  end

  def test_it_can_return_ids
    actual   = @invoice.find_by_id(1)
    expected = @invoice.all[0]

    assert_equal expected, actual
  end

  def test_it_can_find_all_by_customer_id
    actual = @invoice.find_all_by_customer_id(2)
    expected = [@invoice.all[8], @invoice.all[9], @invoice.all[10], @invoice.all[11]]

    assert_equal expected, actual
  end

  def test_it_can_find_all_by_merchant_id
    actual = @invoice.find_all_by_merchant_id(12335938).count
    expected = 3

    assert_equal expected, actual
  end

  def test_it_can_find_all_by_status
    actual = @invoice.find_all_by_status("pending").count
    expected = 162

    assert_equal expected, actual
  end

end
