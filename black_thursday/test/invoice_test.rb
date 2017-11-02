# require_relative 'test_helper'
# require 'time'
# require_relative './../lib/invoice'
# require_relative './../lib/invoice_repository'
# require_relative './../lib/sales_engine'
#
# class InvoiceTest < Minitest::Test
#   attr_reader :repository,
#               :engine
#
#   def setup
#     @engine = SalesEngine.from_csv(
#       items: './test/fixtures/truncated_items.csv',
#       merchants: './test/fixtures/truncated_merchants.csv',
#       invoice: './test/fixtures/truncated_invoices.csv'
#     )
#
#     @repository = InvoiceRepository.new('./test/fixtures/truncated_invoices.csv', engine)
#   end
#
#   def test_it_exists
#     created_at = "2016-01-11 09:34:06 UTC"
#     updated_at = "2017-06-04 21:35:10 UTC"
#
#     invoice = Invoice.new({
#       :id          => 6,
#       :customer_id => 7,
#       :merchant_id => 8,
#       :status      => "pending",
#       :created_at  => created_at,
#       :updated_at  => updated_at},
#       repository
#     )
#
#     assert_instance_of Invoice, invoice
#   end
# end
