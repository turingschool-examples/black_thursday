require './test/test_helper'
require './lib/invoice_repository'
require './lib/invoice'

class InvoiceRepositoryTest < Minitest::Test
  def setup
    @invoice_1 = Invoice.new({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 10,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
      })
    @invoice_2 = Invoice.new({
      :id          => 7,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
      })
    @invoice_3 = Invoice.new({
      :id          => 8,
      :customer_id => 9,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
      })
    @inr = InvoiceRepository.new
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @inr
  end

  def test_it_can_add_invoice
    @inr.add_invoice(@invoice_1)
    assert_equal [@invoice_1], @inr.all
  end
end
