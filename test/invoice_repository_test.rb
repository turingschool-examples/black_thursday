require_relative 'test_helper'
require_relative '../lib/invoice_repository.rb'
require 'pry'

class InvoiceRepositoryTest < Minitest::Test
  def setup
    @invoice_repository = InvoiceRepository.new("./data/invoices.csv")
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @invoice_repository
  end

  def test_it_can_hold_invoices
    assert_instance_of Array, @invoice_repository.invoices
  end

  def test_its_holding_invoices
    assert_instance_of Invoice, @invoice_repository.invoices[0]
    assert_instance_of Invoice, @invoice_repository.invoices[25]
  end

  def test_it_can_return_items_using_all
    assert_instance_of Invoice, @invoice_repository.all[5]
    assert_instance_of Invoice, @invoice_repository.all[97]
  end

  def test_it_can_find_by_id
    expected = @invoice_repository.invoices[0]
    actual = @invoice_repository.find_by_id(1)
    assert_equal expected, actual
  end

  def test_it_can_find_all_by_customer_id
    expected = 8
    actual = @invoice_repository.find_all_by_customer_id(1).count
    assert_equal expected, actual
  end

  def test_it_can_find_all_by_merchant_id
    expected = 16
    actual = @invoice_repository.find_all_by_merchant_id(12335938).count
    assert_equal expected, actual
  end

  def test_it_can_find_all_by_status
    expected = 1473
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
    expected = @invoice_repository.invoices[-1]
    actual = new_invoice_added
    assert_equal expected, actual
  end

  def test_it_can_update_attributes
    new_invoice_added = @invoice_repository.create({
        :customer_id => 7,
        :merchant_id => 8,
        :status      => "pending"
      })

    assert_equal @invoice_repository.invoices.last.customer_id, new_invoice_added.customer_id
    assert_equal @invoice_repository.invoices.last.merchant_id, new_invoice_added.merchant_id
    assert_equal @invoice_repository.invoices.last.status, new_invoice_added.status

    @invoice_repository.update(4986, {:status => "shipped"})

    assert_equal "shipped", new_invoice_added.status
  end
end
