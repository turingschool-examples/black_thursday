require './test/test_helper'
require './lib/sales_engine.rb'

class SalesEngineTest < Minitest::Test 
  
  def test_has_instance_variable_for_each_repo
    se = SalesEngine.new
    
    assert_instance_of MerchantRepository, se.merchants 
    assert_instance_of ItemRepository, se.items 
    # assert_instance_of InvoiceRepository, se.invoices 
    # assert_instance_of InvoiceItemRepository, se.invoice_items   
    # assert_instance_of TransactionRepository, se.transactions 
    # assert_instance_of CustomerRepository, se.customers 
  end
  
  
  
end
