require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repository'
require './lib/merchant_repository'
require './lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test
attr_reader :se, :invoice_repo

  def setup
    invoice_file = './data/test_invoices.csv'

    @invoice_repo = InvoiceRepository.new(invoice_file)
  end

  def test_an_instance_of_invoice_repo_exists
    assert invoice_repo.instance_of?(InvoiceRepository)
  end

  def test_invoice_repo_can_load_data
    assert_equal 19, invoice_repo.all.count
  end

  #replicate this test in all repos
  def test_invoice_repo_all_method_always_returns_instance_of_invoice
    expected = invoice_repo.all
    expected.each do |invoice|
      assert_equal Invoice, invoice.class
    end
  end

  def test_find_by_id_defaults_nil
    assert_equal nil, invoice_repo.find_by_id(56)
  end

  def test_find_by_id_works
    assert invoice_repo.find_by_id(1)
  end

  def test_find_all_by_customer_id_defaults_to_empty_array
    assert_equal [], invoice_repo.find_all_by_customer_id(99)
  end

  def test_find_all_by_customer_id_returns_matching_invoices
    assert_equal 8, invoice_repo.find_all_by_customer_id(1).count
  end

  def test_find_all_by_merchant_id_returns_an_empty_array
    assert_equal [], invoice_repo.find_all_by_merchant_id(65)
  end

  def test_find_all_by_merchant_id_returns_matching_invoices
    assert_equal 2, invoice_repo.find_all_by_merchant_id(12335955).count
  end

  def test_find_all_by_status_returns_an_empty_array_when_status_unknown
    assert_equal [], invoice_repo.find_all_by_status(:none)
  end

  def test_find_all_by_status_returns_array_of_shipped_invoices
      assert_equal 9, invoice_repo.find_all_by_status(:shipped).count
  end

  def test_find_all_by_status_returns_array_of_pending_invoices
    assert_equal 9, invoice_repo.find_all_by_status(:pending).count
  end

  def test_find_all_by_status_returns_array_of_returned_invoices
    assert_equal 1, invoice_repo.find_all_by_status(:returned).count
  end
end
