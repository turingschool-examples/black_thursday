require './test/test_helper'
require './lib/invoice_repository'
require './lib/invoice'

class InvoiceRepositoryTest < Minitest::Test
  def setup
    @invoice_1 = Invoice.new({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 10,
      :status      => :pending,
      :created_at  => Time.now,
      :updated_at  => Time.now,
      })
    @invoice_2 = Invoice.new({
      :id          => 7,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => :shipped,
      :created_at  => Time.now,
      :updated_at  => Time.now,
      })
    @invoice_3 = Invoice.new({
      :id          => 8,
      :customer_id => 9,
      :merchant_id => 8,
      :status      => :pending,
      :created_at  => Time.now,
      :updated_at  => Time.now,
      })
    @inr = InvoiceRepository.new
    @inr.add_invoice(@invoice_1)
    @inr.add_invoice(@invoice_2)
    @inr.add_invoice(@invoice_3)
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @inr
  end

  def test_it_can_add_invoice
    assert_equal [@invoice_1, @invoice_2, @invoice_3], @inr.all
  end

  def test_it_can_find_by_id
    assert_equal @invoice_1, @inr.find_by_id(6)
    assert_nil @inr.find_by_id(243)
  end

  def test_it_can_find_all_by_customer_id
    assert_equal [@invoice_1, @invoice_2], @inr.find_all_by_customer_id(7)
    assert_equal [], @inr.find_all_by_customer_id(24)
  end

  def test_it_can_find_all_by_merchant_id
    assert_equal [@invoice_2, @invoice_3], @inr.find_all_by_merchant_id(8)
    assert_equal [], @inr.find_all_by_merchant_id(428)
  end

  def test_it_can_find_all_by_status
    assert_equal [@invoice_2], @inr.find_all_by_status(:shipped)
    assert_equal [], @inr.find_all_by_status(:lost)
  end

  def test_it_can_create_new_invoice_with_attributes
    @inr.create({:customer_id => 12,
    :merchant_id => 8,
    :status      => :pending,
    :created_at  => Time.now,
    :updated_at  => Time.now})
    assert_equal 9, @inr.all.last.id
  end

  def test_it_can_update_invoice_with_attributes
    assert_equal :pending, @inr.find_by_id(8).status
    attributes = {status: :shipped}
    @inr.update(8, attributes)
    assert_equal :shipped, @inr.find_by_id(8).status
  end

  def test_it_can_delete_invoice
    assert_equal @invoice_1, @inr.find_by_id(6)
    @inr.delete(6)
    assert_nil @inr.find_by_id(6)
  end

end
