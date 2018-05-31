require_relative 'test_helper'
require './lib/sales_engine'
require './lib/invoice_repository'
require './lib/invoice'

class InvoiceRepositoryTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
      :items => './data/items.csv',
      :merchants => './data/merchants.csv',
      :invoices => './data/invoices.csv'
    })
    @invoice_repository = @se.invoices
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @invoice_repository
  end

  def test_invoice_repo_holds_all_instances_of_invoices
    assert_equal 4985, @invoice_repository.all.length
  end

  def test_all_returns_array_of_all_invoice_objects
    invoices = @invoice_repository.all
    assert invoices.all? do |invoice|
      invoice.class == Invoice
    end
  end

  def test_find_by_id_returns_invoices_with_given_id
    invoices = @invoice_repository.all
    refute @invoice_repository.find_by_id('notarealid')
    assert_instance_of Invoice, @invoice_repository.find_by_id(2)
    assert_equal 12334753, @invoice_repository.find_by_id(2).merchant_id

    result = :pending
    assert_equal result, @invoice_repository.find_by_id(6).status
  end

  def test_find_all_by_customer_id_returns_invoices_with_given_id
    invoices = @invoice_repository.all
    assert_equal 5, @invoice_repository.find_all_by_customer_id(6).length
  end

  def test_find_all_by_merchant_id
    invoices = @invoice_repository.all
    assert_equal 15, @invoice_repository.find_all_by_merchant_id(12334753).length
  end

  def test_find_all_by_status
    invoices = @invoice_repository.all
    assert_equal 1473, @invoice_repository.find_all_by_status(:pending).length
    assert_equal 673, @invoice_repository.find_all_by_status(:returned).length
  end
end
