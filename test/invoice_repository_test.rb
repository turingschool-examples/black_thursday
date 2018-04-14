require_relative 'test_helper'
require './lib/invoice_repository'
require 'pry'

class InvoiceRepositoryTest < Minitest::Test

  def setup
    @now = Time.now
    @invoice1 = Invoice.new({
        :id          => 6,
        :customer_id => 7,
        :merchant_id => 8,
        :status      => "pending",
        :created_at  => @now,
        :updated_at  => @now,
        })
    @invoice2 = Invoice.new({
      :id            => 7,
      :customer_id   => 8,
      :merchant_id   => 9,
      :status        => "success",
      :created_at    => @now,
      :updated_at    => @now
      })
    @invoice3 = Invoice.new({
      :id            => 8,
      :customer_id   => 9,
      :merchant_id   => 10,
      :status        => "processing",
      :created_at    => @now,
      :updated_at    => @now
      })
    @invoices = [@invoice1, @invoice2, @invoice3]
    @ir = InvoiceRepository.new(@invoices)
  end

  def test_it_exists
    @ir
    assert_instance_of InvoiceRepository, @ir
  end

  def test_can_find_by_id
    expected = @ir.find_by_id(6)
    assert_equal "pending", expected.status
    expected = @ir.find_by_id(7)
    assert_equal 8, expected.merchant_id
  end

  # def test_it_can_update_an_invoice
  #   @se
  #   original_time = engine.invoices.find_by_id(6).status
  #   attributes = {
  #     status: "pending"
  #   }
  #   engine.invoices.update(4986, attributes)
  #   expected = engine.invoices.find_by_id(4986)
  #   expect(expected.status).to eq :success
  #   expect(expected.customer_id).to eq 7
  #   expect(expected.updated_at).to be > original_time
  # end


end
