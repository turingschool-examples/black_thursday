require './test/test_helper'
require './lib/invoice_repo'

class InvoiceRepositoryTest < Minitest::Test

  def setup
    csvfile = CSV.open "./data/invoices.csv", headers: true, header_converters: :symbol
    @invoice_repo = InvoiceRepository.new(csvfile, "engine")
  end

  def test_it_exist
    assert_instance_of InvoiceRepository, @invoice_repo
  end

  def test_can_find_by_id
    id = 1
    invalid_id = 0

    assert_instance_of Invoice, @invoice_repo.find_by_id(id)
    assert_nil @invoice_repo.find_by_id(invalid_id)
  end

  def test_it_can_find_all_by_customer_id
    customer_id = 1

    assert_instance_of Array, @invoice_repo.find_all_by_customer_id(customer_id)
  end

  def test_invoices_are_placed_in_array
    assert_instance_of Invoice, @invoice_repo.all[0]
  end

  def test_can_find_all_by_merchant_id
    merchant_id = 12335938

    assert_instance_of Array, @invoice_repo.find_all_by_merchant_id(merchant_id)
  end

end
