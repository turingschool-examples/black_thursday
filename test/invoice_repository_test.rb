require_relative 'test_helper'
require_relative '../lib/invoice_repository.rb'
require 'pry'

class InvoiceRepositoryTest < Minitest::Test
  def setup
    invoice_1 = Invoice.new({
      id: 1,
      customer_id: 10,
      merchant_id: 123,
      status: "pending",
      created_at: "2004-02-17",
      updated_at: "2014-03-15"
      })
    invoice_2 = Invoice.new({
      id: 2,
      customer_id: 10,
      merchant_id: 124,
      status: "shipped",
      created_at: "2009-02-07",
      updated_at: "2012-03-15"
      })
    invoice_3 = Invoice.new({
      id: 3,
      customer_id: 12,
      merchant_id: 125,
      status: "returned",
      created_at: "1997-07-31",
      updated_at: "2014-02-11"
      })

    invoices = [invoice_1, invoice_2, invoice_3]
    @invoice_repository = InvoiceRepository.new(invoices)
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @invoice_repository
  end

  def test_it_can_hold_invoices
    assert_instance_of Array, @invoice_repository.list
  end

  def test_its_holding_invoices
    assert_instance_of Invoice, @invoice_repository.list[0]
    assert_instance_of Invoice, @invoice_repository.list[2]
  end

  def test_it_can_return_invoices_using_all
    assert_instance_of Invoice, @invoice_repository.all[1]
    assert_instance_of Invoice, @invoice_repository.all[2]
  end

  def test_it_can_find_by_id
    expected = @invoice_repository.list[0]
    actual = @invoice_repository.find_by_id(1)
    assert_equal expected, actual
  end

  def test_it_can_find_all_by_customer_id
    expected = 2
    actual = @invoice_repository.find_all_by_customer_id(10).count
    assert_equal expected, actual
  end

  def test_it_can_find_all_by_merchant_id
    expected = 1
    actual = @invoice_repository.find_all_by_merchant_id(125).count
    assert_equal expected, actual
  end

  def test_it_can_find_all_by_status
    expected = 1
    actual = @invoice_repository.find_all_by_status("pending").count
    assert_equal expected, actual
  end

  def test_it_create_new_invoice_with_attributes
    new_invoice_added = @invoice_repository.create({
        :customer_id => 7,
        :merchant_id => 8,
        :status      => "pending",
        :created_at  => Time.now,
        :updated_at  => Time.now,
      })
    expected = @invoice_repository.list[-1]
    actual = new_invoice_added
    assert_equal expected, actual
  end

  def test_it_can_update_attributes
    new_invoice_added = @invoice_repository.create({
        :customer_id => 7,
        :merchant_id => 8,
        :status      => "pending"
      })

    assert_equal @invoice_repository.list.last.customer_id, new_invoice_added.customer_id

    @invoice_repository.update(4, {:status => "shipped"})

    assert_equal "shipped", new_invoice_added.status
  end

  def test_it_can_delete_item
    assert_equal @invoice_repository.list[0], @invoice_repository.find_by_id(1)

    @invoice_repository.delete(1)
    assert_nil @invoice_repository.find_by_id(1)
  end
end
