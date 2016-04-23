require_relative 'test_helper'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test
  def setup
    invoice1 = Invoice.new({
    :id          => 6,
    :customer_id => 7,
    :merchant_id => 8,
    :status      => "pending",
    :created_at  => Time.new.to_s,
    :updated_at  => Time.new.to_s,
    })

    invoice2 = Invoice.new({
    :id          => 9,
    :customer_id => 38,
    :merchant_id => 93,
    :status      => "shipped",
    :created_at  => Time.new.to_s,
    :updated_at  => Time.new.to_s,
    })

    @invoice = InvoiceRepository.new
    @invoice.invoice_repository = ([invoice1, invoice2])
  end

  def test_it_creates_a_new_instance_of_invoice_repo
    assert_equal InvoiceRepository, @invoice.class
  end

  def test_it_returns_an_array_of_all_invoice_instances
    assert_equal 2, @invoice.all.length
  end

  def test_it_can_return_an_invoice_by_invoice_id
    invoice_instance = @invoice.find_by_id(9)
    assert_equal :shipped ,invoice_instance.status
  end

  def test_it_will_return_nil_if_invoice_item_does_not_exist
    assert_equal nil, @invoice.find_by_id(124)
  end

  def test_it_can_return_an_array_of_invoices_by_customer_id
    invoice_instance = @invoice.find_all_by_customer_id(38)
    assert_equal :shipped ,invoice_instance[0].status
  end

  def test_it_will_return_an_empty_array_if_customer_id_doesnt_exist
    assert_equal [], @invoice.find_all_by_customer_id(124)
  end

  def test_it_can_return_an_array_of_invoices_by_merchant_id
    invoice_instance = @invoice.find_all_by_merchant_id(93)
    assert_equal :shipped ,invoice_instance[0].status
  end

  def test_it_will_return_an_empty_array_if_merchant_id_doesnt_exist
    assert_equal [], @invoice.find_all_by_merchant_id(124)

  end

end
