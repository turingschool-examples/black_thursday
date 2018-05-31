require './test/test_helper'
require './lib/invoice_repository'
require './lib/repository'
require 'time'
require 'pry'

class InvoiceRepositoryTest < Minitest::Test
  def setup
    invoice_repo = InvoiceRepository.new
    invoice_1 = ({
      id: "1",
      customer_id: "1",
      merchant_id: "12335938",
      status: "pending",
      created_at: "2009-02-07",
      updated_at: "2014-03-15"
    })
    invoice_2 = ({
      id: "2",
      customer_id: "1",
      merchant_id: "12334753",
      status: "shipped",
      created_at: "2012-11-23",
      updated_at: "2013-04-14"
    })
    invoice_3 = ({
      id: "3",
      customer_id: "1",
      merchant_id: "12335955",
      status: "shipped",
      created_at: "2009-12-09",
      updated_at: "2010-07-10"
    })

    invoice_repo.create(invoice_1)
    invoice_repo.create(invoice_2)
    invoice_repo.create(invoice_3)
    @ir = invoice_repo
  end

  def test_invoice_repository_exists
    assert_instance_of InvoiceRepository, @ir
  end

  def test_invoice_repository_holds_only_invoices
    assert_equal true, @ir.members.all? do |member|
      member.class == Invoice
    end
  end

  def test_invoice_repository_can_find_invoice_by_id
    assert_instance_of Invoice, @ir.find_by_id(2)
    assert_equal 1, @ir.find_by_id(2).customer_id
    assert_equal :shipped, @ir.find_by_id(2).status
  end

  def test_invoice_repository_can_find_invoice_by_customer_id
    by_customer_id = @ir.find_all_by_customer_id(1)

    assert_equal 3, by_customer_id.length
  end

  def test_invoice_repository_can_find_invoice_by_merchant_id
    by_merchant_id = @ir.find_all_by_merchant_id(12335955)

    assert_equal 1, by_merchant_id.length
  end

  def test_invoice_repository_can_find_invoice_by_status
    by_status = @ir.find_all_by_status("shipped")

    assert_equal 2, by_status.length
  end

  def test_invoice_repository_can_update_an_invoice
    updated = @ir.update(1, {status: "pending"})

    assert_equal :pending, updated.status
    assert_equal :pending, @ir.members[0].status
  end

  def test_invoice_repository_can_delete_an_invoice
    assert_equal 3, @ir.members.length

    @ir.delete(1)

    assert_equal 2,  @ir.members.length
  end
end
