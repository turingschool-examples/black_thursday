require_relative 'test_helper'
require_relative '../lib/invoice_repository'
require_relative '../lib/sales_engine'

class InvoiceRepositoryTest < Minitest::Test
  attr_reader :se, :invoice_repo
  def setup
    @se = SalesEngine.from_csv({
      :invoices => "./data/small_invoices.csv" })
    @invoice_repo = @se.invoices
  end

  def test_invoice_all_finds_all
    assert_equal 10, invoice_repo.all.length
  end

  def test_invoice_repo_all_can_identify_invoice_object
    assert_equal 1, invoice_repo.all[0].id
  end

  def test_invoice_can_find_by_id
    assert_equal 12334839, invoice_repo.find_by_id(10).merchant_id
  end

  def test_we_can_find_all_by_customer_id
    assert_equal 2, invoice_repo.find_all_by_customer_id(2).length
  end

  def test_we_can_identify_find_all_by_customer_id_data
    assert_equal 12336965, invoice_repo.find_all_by_customer_id(2)[0].merchant_id
  end

  def test_we_can_find_all_by_merchant_id
    assert_equal 2, invoice_repo.find_all_by_merchant_id(12335938).length
  end

  def test_we_can_find_all_by_merchant_id_was_created_at
    assert_equal Time.parse("2012-11-23") , invoice_repo.find_all_by_merchant_id(12335938)[1].created_at
  end

  def test_we_can_find_by_status
    assert_equal 4, invoice_repo.find_all_by_status("shipped").length
  end

  def test_we_can_identify_merchant_id_by_status
    assert_equal 12335955, invoice_repo.find_all_by_status("shipped")[1].merchant_id
  end

end
