require_relative '../lib/invoice_repository'
require_relative '../lib/invoice'
require_relative './test_helper'

class InvoiceRepositoryTest < Minitest::Test
  def setup
    @invoices =
      [{id: 1,
      customer_id: 1,
      merchant_id: 1111,
      status: 'shipped',
      created_at: '2010-11-10',
      updated_at: '2011-11-04'},
      {id: 2,
      customer_id: 2,
      merchant_id: 2222,
      status: 'pending',
      created_at: '2013-12-10',
      updated_at: '2013-12-04'},
      {id: 3,
      customer_id: 2,
      merchant_id: 2222,
      status: 'pending',
      created_at: '2010-03-10',
      updated_at: '2011-03-04'}]

    @invoice_repository = InvoiceRepository.new(@invoices)
  end

  def test_it_exist
    assert_instance_of InvoiceRepository, @invoice_repository
  end

  def test_it_can_build_invoice
    assert_equal Array, @invoice_repository.build_invoice(@invoices).class
  end

  def test_can_get_an_array_of_invoices
    assert_equal 3, @invoice_repository.all.count
  end

  def test_it_can_find_a_invoice_by_a_valid_id
    invoice = @invoice_repository.find_by_id(1)
    assert_instance_of Invoice, invoice
    assert_equal 1, invoice.id
  end

  def test_it_returns_nil_if_invoice_id_is_invalid
    invoice = @invoice_repository.find_by_id('invalid')
    assert_nil invoice
  end

  def test_it_can_find_all_invoices_by_customer_id
    invoices_1 = @invoice_repository.find_all_by_customer_id(1)
    invoices_2 = @invoice_repository.find_all_by_customer_id(2)
    invoices_3 = @invoice_repository.find_all_by_customer_id(3)
    assert_equal 1, invoices_1.first.customer_id
    assert_equal 2, invoices_2.first.customer_id
    assert_equal 2, invoices_2[-1].customer_id
    assert_equal ([]), invoices_3
  end

  def test_it_can_find_all_invoices_by_merchant_id
    invoices_1 = @invoice_repository.find_all_by_merchant_id(1111)
    invoices_2 = @invoice_repository.find_all_by_merchant_id(2222)
    invoices_3 = @invoice_repository.find_all_by_merchant_id(3333)
    assert_equal 1111, invoices_1.first.merchant_id
    assert_equal 2222, invoices_2.first.merchant_id
    assert_equal 2222, invoices_2[-1].merchant_id
    assert_equal ([]), invoices_3
  end

  def test_it_can_find_all_invoices_by_status
    invoices_1 = @invoice_repository.find_all_by_status('shipped')
    invoices_2 = @invoice_repository.find_all_by_status('pending')
    invoices_3 = @invoice_repository.find_all_by_status('status DNE')
    assert_equal 'shipped', invoices_1.first.status
    assert_equal 'pending', invoices_2.first.status
    assert_equal 'pending', invoices_2[-1].status
    assert_equal ([]), invoices_3
  end

  def test_it_can_create_new_id
    invoice = @invoice_repository.create_id
    assert_equal 4, invoice
  end

  def test_it_can_create_new_invoice
    attributes = {  customer_id: 27,
                    merchant_id: 2772,
                    status: 'shipping',
                    created_at: '2010-12-10',
                    updated_at: '2011-12-04',
                  }
    invoice = @invoice_repository.create(attributes)
    assert_equal 4, invoice.id
    assert_equal 27, invoice.customer_id
    assert_equal 2772, invoice.merchant_id
    assert_equal 'shipping', invoice.status
    assert_instance_of Time, invoice.created_at
    assert_instance_of Time, invoice.updated_at
  end

  def test_it_can_update_invoice_status_and_time_it_was_updated_at
    attributes = {
      status: 'pending'
    }
    id = 1
    invoice = @invoice_repository.update(id, attributes)
    expected = @invoice_repository.find_by_id(id)
    assert_instance_of Time, invoice.updated_at # maybe refactor later
    assert_equal 1111, expected.merchant_id
    expected = @invoice_repository.find_all_by_status('shipped')
    assert_equal ([]), expected
  end

  def test_it_can_delete_invoice
    id = 2

    invoice = @invoice_repository.delete(id)
    expected = @invoice_repository.find_by_id(2)

    assert_nil expected
  end
end
