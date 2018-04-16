# require 'time'
# require_relative 'test_helper'
# require './lib/transaction_repository'
# require './lib/sales_engine'
# require 'pry'
#
# # transaction repo test
# class TransactionRepositoryTest < Minitest::Test
#   def setup
#     @se = SalesEngine.from_csv(
#       {
#         items:         './test/fixtures/items_truncated.csv',
#         merchants:     './test/fixtures/merchants_truncated.csv',
#         invoices:      './test/fixtures/invoices_truncated.csv',
#         invoice_items: './test/fixtures/invoice_items_truncated.csv'
#       } )
#
#     @t = @se.transactions
#   end
#
#   def test_it_exists
#     assert_instance_of TransactionRepository, @t
#   end
#
#   def test_it_has_items
#     assert_equal 10, @t.all.count
#     assert_instance_of Array, @t.all
#   end
#
#   def test_find_by_id
#     assert_instance_of InvoiceItem, @t.find_by_id(1)
#   end
#
#   def test_find_invoice_items_by_id
#     assert_nil @t.find_by_id(777)
#     assert_instance_of Transaction, @t.find_by_id(1)
#   end
#
#   def test_find_all_by_item_id
#     actual = @t.find_all_by_item_id(1)
#
#     assert_instance_of Array, actual
#     assert_equal 4, actual.count
#   end
#
#   def test_find_all_by_invoice_id
#     actual = @t.find_all_by_invoice_id(1)
#
#     assert_instance_of Array, actual
#     assert_equal 8, actual.count
#   end
#
#   def test_create_invoice_item
#     assert_equal 10, @t.invoice_items.last.id
#
#     @t.create({
#                 :item_id => 11,
#                 :invoice_id => 12,
#                 :quantity => 13,
#                 :unit_price => 10
#               })
#
#     actual = @t.invoice_items.last
#
#     assert_equal 11, actual.id
#     assert_equal 11, actual.item_id
#     assert_equal 13, actual.quantity
#     assert_equal 0.1, actual.unit_price
#   end
#
#   def test_update_item
#     attributes = ({
#                     :quantity => 7,
#                     :unit_price => 15
#                    })
#
#     to_update = @t.find_by_id(10)
#
#     assert_equal 4, to_update.quantity
#     assert_equal 18.59, to_update.unit_price
#
#     @t.update(10, attributes)
#
#     assert_equal 7, to_update.quantity
#     assert_equal 15, to_update.unit_price
#   end
#
#   def test_delete_item
#     actual = @t.invoice_items
#
#     assert_equal 10, actual.count
#
#     @t.delete(1)
#
#     assert_nil @t.find_by_id(1)
#     assert_equal 9, actual.count
#   end
# end
