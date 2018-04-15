require './lib/invoice'
require 'time'
require_relative 'test_helper'
require './lib/invoice_repository'
require 'pry'

class InvoiceRepositoryTest < Minitest::Test

  def setup
    @invoice1 = [
      [:id, '2'],
      [:customer_id, '1'],
      [:merchant_id, '12334753'],
      [:status, 'shipped'],
      [:created_at, '2012-11-23'],
      [:updated_at, '2013-04-14']
      ]
    @invoice2 = [
      [:id, '11'],
      [:customer_id, '2'],
      [:merchant_id, '12334771'],
      [:status, 'pending'],
      [:created_at, '2008-01-07'],
      [:updated_at, '2014-05-30']
      ]
    @invoice3 = [
      [:id, '27'],
      [:customer_id, '6'],
      [:merchant_id, '12335319'],
      [:status, 'shipped'],
      [:created_at, '2011-06-21'],
      [:updated_at, '2013-07-22']
      ]
    @invoices = [@invoice1, @invoice2, @invoice3]
    @ir = InvoiceRepository.new(@invoices)
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @ir
  end

  def test_it_holds_invoices
    @ir.invoices.all? do |invoice|
      assert_instance_of Invoice, invoice
    end
    assert_instance_of Invoice, @ir.invoices[0]
    assert_instance_of Invoice, @ir.invoices[1]
  end

  def test_it_can_find_all
    @ir.all.all? do |invoice|
      assert_instance_of Invoice, invoice
    end
  end

  def test_can_find_by_id
    actual = @ir.find_by_id(2)
    assert_equal :shipped, actual.status

    actual = @ir.find_by_id(27)
    assert_equal 12335319, actual.merchant_id

    actual = @ir.find_by_id(11)
    assert_equal 2, actual.customer_id
  end

  def test_can_find_all_by_customer_id
    actual = @ir.find_all_by_customer_id(6)
    assert_equal 27, actual[0].id

    actual = @ir.find_all_by_customer_id(2)
    assert_equal 12334771, actual[0].merchant_id

    actual = @ir.find_all_by_customer_id(1)
    assert_equal :shipped, actual[0].status
  end

  def test_can_find_all_by_merchant_id
    actual = @ir.find_all_by_merchant_id(12334771)
    assert_equal 11, actual[0].id

    actual = @ir.find_all_by_merchant_id(12334753)
    assert_equal 1, actual[0].customer_id

    actual = @ir.find_all_by_merchant_id(12335319)
    assert_equal :shipped, actual[0].status
  end

  def test_can_find_all_by_status
    actual = @ir.find_all_by_status(:shipped)
    assert_equal 27, actual[1].id

    actual = @ir.find_all_by_status(:shipped)
    assert_equal 1, actual[0].customer_id

    actual = @ir.find_all_by_status(:pending)
    assert_equal 12334771, actual[0].merchant_id
  end

  def test_can_find_highest_id
    actual = @ir.find_highest_id
    assert_equal 27, actual
  end 

  def test_ir_can_create_new_invoice
    actual = @ir.find_highest_id
    assert_equal 27, actual
    assert_equal :shipped, @ir.find_by_id(27).status
    attributes = {:customer_id => 7,
                  :merchant_id => 8,
                  :status      => "pending",
                  :created_at  => Time.now,
                  :updated_at  => Time.now}
    @ir.create(attributes)
    assert_equal 28, @ir.find_highest_id
    actual = @ir.find_by_id(28)
    assert_equal 8, actual.merchant_id
    assert_equal :pending, actual.status
  end

  def test_ir_can_update_an_invoice
    invoice = @ir.find_by_id(27)
    assert_equal :shipped, invoice.status
    assert_equal Time.parse('2011-06-21'), invoice.updated_at
    assert_equal Time.parse('2013-07-22'), invoice.updated_at
    attributes = {
          status: "pending"
        }
    @ir.update(27, attributes)
    invoice = @ir.find_by_id(27)
    assert_equal :pending, invoice.status
  end
end
