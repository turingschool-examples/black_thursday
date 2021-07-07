require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_item_repo'

class InvoiceItemRepoTest < MiniTest::Test
  attr_reader :ir

   def setup
     @ir = InvoiceItemRepo.new("./data/invoice_items.csv")
   end

   def test_it_exists
     assert_instance_of InvoiceItemRepo, ir
   end

   def test_all_returns_all_invoice_items
     assert_equal 21830, ir.all.count
   end

   def test_find_by_id_will_return_matching_invoice_item
     assert_equal 263539664, ir.find_by_id(6).item_id
   end

   def test_find_all_by_item_id_returns_all_with_matching_item_id
     assert_instance_of InvoiceItem, ir.find_all_by_item_id(263519844)[0]
     assert_equal 164, ir.find_all_by_item_id(263519844).count
     assert_equal [], ir.find_all_by_item_id(0)
   end

   def test_find_all_by_invoice_id_returns_all_matching_instances
     assert_instance_of InvoiceItem, ir.find_all_by_invoice_id(3)[0]
     assert_equal 8, ir.find_all_by_invoice_id(3).count
   end
   
end
