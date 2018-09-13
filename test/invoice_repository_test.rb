require './test/test_helper'
require './lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test
  def test_it_exists
    invoice_repository = InvoiceRepository.new("./data/invoices.csv")
    assert_instance_of InvoiceRepository, invoice_repository
  end

  def test_it_has_invoices
    invoice_repository = InvoiceRepository.new("./data/invoices.csv")
    assert_equal 4985, invoice_repository.all.count

    assert_equal 1, invoice_repository.all.first.id
  end

  def test_it_can_find_item_by_id
    invoice_repository = InvoiceRepository.new("./data/invoices.csv")

    actual = invoice_repository.find_by_id(1)

    assert_instance_of Invoice, actual

    assert_equal 1, actual.id
  end

  def test_returns_nil_when_no_match_is_found
    invoice_repository = InvoiceRepository.new("./data/invoices.csv")

    actual = invoice_repository.find_by_id(99999)

    assert_nil actual
  end

  def test_it_can_find_all_by_customer_id
    invoice_repository = InvoiceRepository.new("./data/invoices.csv")
    actual = invoice_repository.all[0]

    assert_equal actual, invoice_repository.find_all_by_customer_id(1)[0]

    assert_equal [], invoice_repository.find_all_by_customer_id(99999)

    assert_equal 1, actual.id
  end

  def test_it_can_find_all_by_merchant_id
    invoice_repository = InvoiceRepository.new("./data/invoices.csv")
    actual = invoice_repository.all[0]

    assert_equal actual, invoice_repository.find_all_by_merchant_id(1)[0]

    assert_equal [], invoice_repository.find_all_by_merchant_id(99999)

    assert_equal 1, actual.id
  end

  def test_it_can_find_all_by_status
    invoice_repository = InvoiceRepository.new("./data/invoices.csv")

    assert_equal 1473, invoice_repository.find_all_by_status(:pending).count

    assert_equal [], invoice_repository.find_all_by_status("thisisnotastatus")
  end

  def test_it_can_create_an_invoice
    invoice_repository = InvoiceRepository.new("./data/invoices.csv")

    new_invoice = invoice_repository.create(customer_id: 7, merchant_id: 8, status: "pending")

    assert_instance_of Invoice, new_invoice

    actual = invoice_repository.all.last

    assert_equal invoice_repository.find_by_id(4986), actual
  end

  def test_it_can_update_an_invoice
    invoice_repository = InvoiceRepository.new("./data/invoices.csv")

    id = (1)
    attributes = {status: "success"}

    invoice_repository.update(id, attributes)

    assert_equal 1, invoice_repository.find_by_id(id).id

    assert_equal :success, invoice_repository.find_by_id(id).status
  end

  def test_it_can_delete_an_invoice
    invoice_repository = InvoiceRepository.new("./data/invoices.csv")

    invoice_repository.delete(1)

    assert_nil invoice_repository.find_by_id(1)
  end
end
