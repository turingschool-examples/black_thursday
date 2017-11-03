require_relative 'test_helper'
require './lib/invoice_repository'
require 'pry'
require 'csv'
require 'date'
require 'bigdecimal'

class InvoiceTest < Minitest:: Test
  def test_it_knows_it_came_from
    invoice_repo = InvoiceRepository.new("")
    invoice_repo.create_invoice(
    "./test/fixtures/items_fixture_5lines.csv",
    )
    invoice = invoice_repo.invoices.first
    assert_equal invoice_repo, invoice.repository
  end

  def test_it_can_create_an_item
      i = Invoice.new({
        :id          => 6,
        :customer_id => 7,
        :merchant_id => 8,
        :status      => "pending",
        :created_at  => Time.now,
        :updated_at  => Time.now,
      })

      assert_instance_of Invoice, i
  end
end
