require_relative 'test_helper'
require_relative '../lib/merchant_repo'
require_relative '../lib/item_repo'
require_relative '../lib/invoice_repo'
require_relative '../lib/invoice_item_repo'
require_relative '../lib/transaction_repo'
require_relative '../lib/customer_repo'
require_relative '../lib/sales_analyst'
require 'bigdecimal'

class SalesAnalystTest < Minitest::Test
  
  def setup
    merchant_array = [
    {:id=>"12334105", :name=>"Shopin1901", :created_at=>"2010-12-10", :updated_at=>"2011-12-04"},
    {:id=>"12334112", :name=>"Candisart", :created_at=>"2009-05-30", :updated_at=>"2010-08-29"},
    {:id=>"12334113", :name=>"Sandy", :created_at=>"2010-03-30", :updated_at=>"2013-01-21"}]
    @mer_repo = MerchantRepo.new(merchant_array)

    item_array = [
    {id: 263395237, name: "Cow1" , description: "animal 1", unit_price: "1400", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334105"},
    {id: 263395238, name: "Cow1", description: "animal 1", unit_price: "1400", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334105"},
    {id: 263395239, name: "cow1", description: "animal 1", unit_price: "1400", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334105"},
    {id: 263395210, name: "Moose1", description: "animal 2", unit_price: "1700", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334112"},
    {id: 263495211, name: "Moose2", description: "animal 3", unit_price: "1800", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334112"},
    {id: 263397515, name: "Pig", description: "animal 4", unit_price: "1400", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334112"},
    {id: 263895112, name: "Pig", description: "animal 4", unit_price: "1400", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334112"},
    {id: 263395240, name: "cow1", description: "animal 1", unit_price: "1400", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334113"},
    {id: 263305218, name: "Moose1", description: "animal 2", unit_price: "1700", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334113"},
    {id: 263395217, name: "Moose2", description: "animal 3", unit_price: "1800", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334113"},
    {id: 263395216, name: "Pig", description: "animal 4", unit_price: "1400", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334113"},
    {id: 263395314, name: "Pig", description: "animal 4", unit_price: "1400", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334113"},
    {id: 263365314, name: "Pig", description: "animal 4", unit_price: "1400", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334113"},
    {id: 263375314, name: "Pig", description: "animal 4", unit_price: "1400", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334113"},
    {id: 263345314, name: "Pig", description: "animal 4", unit_price: "1400", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334113"}]
    @item_repo = ItemRepo.new(item_array)

    invoice_array = [
    {:id=>4981, :customer_id=>"999", :merchant_id=>"12334105", :status=>"returned", :created_at=>"2009-07-07", :updated_at=>"2012-07-04"},
    {:id=>4982, :customer_id=>"999", :merchant_id=>"12334112", :status=>"shipped", :created_at=>"2009-05-29", :updated_at=>"2014-10-02"},
    {:id=>4983, :customer_id=>"999", :merchant_id=>"12334112", :status=>"shipped", :created_at=>"2001-01-13", :updated_at=>"2003-10-13"},
    {:id=>4984, :customer_id=>"999", :merchant_id=>"12334113", :status=>"returned", :created_at=>"2009-10-15", :updated_at=>"2010-01-21"},
    {:id=>4985, :customer_id=>"888", :merchant_id=>"12334113", :status=>"shipped", :created_at=>"2004-04-12", :updated_at=>"2014-01-27"},
    {:id=>4986, :customer_id=>"888", :merchant_id=>"12334113", :status=>"returned", :created_at=>"2009-07-07", :updated_at=>"2012-07-04"},
    {:id=>4987, :customer_id=>"888", :merchant_id=>"12334113", :status=>"shipped", :created_at=>"2009-05-29", :updated_at=>"2014-10-02"},
    {:id=>4988, :customer_id=>"999", :merchant_id=>"12334113", :status=>"shipped", :created_at=>"2001-01-13", :updated_at=>"2003-10-13"},
    {:id=>4989, :customer_id=>"999", :merchant_id=>"12334113", :status=>"pending", :created_at=>"2009-10-15", :updated_at=>"2010-01-21"},
    {:id=>4990, :customer_id=>"777", :merchant_id=>"12334112", :status=>"shipped", :created_at=>"2004-04-12", :updated_at=>"2014-01-27"},
    {:id=>4991, :customer_id=>"777", :merchant_id=>"12334112", :status=>"returned", :created_at=>"2009-07-07", :updated_at=>"2012-07-04"},
    {:id=>4992, :customer_id=>"777", :merchant_id=>"12334105", :status=>"shipped", :created_at=>"2009-05-29", :updated_at=>"2014-10-02"},
    {:id=>4993, :customer_id=>"999", :merchant_id=>"12334112", :status=>"shipped", :created_at=>"2001-01-13", :updated_at=>"2003-10-13"},
    {:id=>4994, :customer_id=>"999", :merchant_id=>"12335541", :status=>"returned", :created_at=>"2009-10-15", :updated_at=>"2010-01-21"},
    {:id=>4995, :customer_id=>"999", :merchant_id=>"12334113", :status=>"shipped", :created_at=>"2004-04-12", :updated_at=>"2014-01-27"}]
    @invoice_repo = InvoiceRepo.new(invoice_array)
    
    invoice_item_array = [
    {:id=>"21829", :item_id=>"263519844", :invoice_id=>"4984", :quantity=>"10", :unit_price=>"13635", :created_at=>"2000-12-10", :updated_at=>"2011-02-05"}, 
    {:id=>"21830", :item_id=>"263519844", :invoice_id=>"4985", :quantity=>"11", :unit_price=>"13636", :created_at=>"2000-12-10", :updated_at=>"2011-02-05"}, 
    {:id=>"21831", :item_id=>"263519846", :invoice_id=>"4985", :quantity=>"12", :unit_price=>"13637", :created_at=>"2000-12-14", :updated_at=>"2011-02-05"}, 
    {:id=>"21832", :item_id=>"263519847", :invoice_id=>"4987", :quantity=>"13", :unit_price=>"13638", :created_at=>"2000-12-14", :updated_at=>"2011-02-05"}, 
    {:id=>"21833", :item_id=>"263519848", :invoice_id=>"4988", :quantity=>"14", :unit_price=>"13639", :created_at=>"2000-12-14", :updated_at=>"2011-02-05"}, 
    {:id=>"21834", :item_id=>"263519849", :invoice_id=>"4989", :quantity=>"15", :unit_price=>"13630", :created_at=>"2000-12-14", :updated_at=>"2011-02-05"}]
    @invoice_item_repo = InvoiceItemRepo.new(invoice_item_array)
    
    #ids still need to be adjusted to match data.
    transaction_array = [{:id=>"1", :invoice_id=>"2170", :credit_card_number=>"4068631943231473", :credit_card_expiration_date=>"0217", :result=>"success", :created_at=>"2012-02-26 20:56:56 UTC", :updated_at=>"2012-02-26 20:56:56 UTC"}, 
    {:id=>"2", :invoice_id=>"2179", :credit_card_number=>"4068631943231474", :credit_card_expiration_date=>"0217", :result=>"success", :created_at=>"2012-02-26 20:56:56 UTC", :updated_at=>"2012-02-26 20:56:56 UTC"}, 
    {:id=>"3", :invoice_id=>"2178", :credit_card_number=>"4068631943231474", :credit_card_expiration_date=>"0217", :result=>"success", :created_at=>"2012-02-26 20:56:56 UTC", :updated_at=>"2012-02-26 20:56:56 UTC"}, 
    {:id=>"4", :invoice_id=>"2179", :credit_card_number=>"4068631943231475", :credit_card_expiration_date=>"0217", :result=>"failed", :created_at=>"2012-02-26 20:56:56 UTC", :updated_at=>"2012-02-26 20:56:56 UTC"}]
    @transaction_repo = TransactionRepo.new(transaction_array)
    
    customer_array = [{:id=>"1", :first_name=>"Joan", :last_name=>"Ondricka", :created_at=>"2012-03-27 14:54:09 UTC", :updated_at=>"2012-03-27 14:54:09 UTC"}, 
    {:id=>"2", :first_name=>"Joey", :last_name=>"Ondricka", :created_at=>"2012-03-27 14:54:09 UTC", :updated_at=>"2012-03-27 14:54:09 UTC"}, 
    {:id=>"3", :first_name=>"Joey", :last_name=>"Hola", :created_at=>"2012-03-27 14:54:09 UTC", :updated_at=>"2012-03-27 14:54:09 UTC"}, 
    {:id=>"4", :first_name=>"Joel", :last_name=>"Hola", :created_at=>"2012-03-27 14:54:09 UTC", :updated_at=>"2012-03-27 14:54:09 UTC"}, 
    {:id=>"5", :first_name=>"Joel", :last_name=>"Funny", :created_at=>"2012-03-27 14:54:09 UTC", :updated_at=>"2012-03-27 14:54:09 UTC"}, 
    {:id=>"6", :first_name=>"Harry", :last_name=>"Clark", :created_at=>"2012-03-27 14:54:09 UTC", :updated_at=>"2012-03-27 14:54:09 UTC"}, 
    {:id=>"7", :first_name=>"Marry", :last_name=>"House", :created_at=>"2012-03-27 14:54:09 UTC"}]
    @customer_repo = CustomerRepo.new(customer_array)
    
    @analyst = SalesAnalyst.new(@mer_repo, @item_repo, @invoice_repo, @invoice_item_repo, @transaction_repo, @customer_repo) 
  end
  

  def test_it_exists
    assert_instance_of SalesAnalyst, @analyst
  end

  def test_it_has_repositories
    assert_instance_of MerchantRepo, @analyst.merchants
    assert_instance_of ItemRepo, @analyst.items
    assert_instance_of InvoiceRepo, @analyst.invoices
    assert_instance_of InvoiceItemRepo, @analyst.invoice_items
    assert_instance_of TransactionRepo, @analyst.transactions
    assert_instance_of CustomerRepo, @analyst.customers
  end

  def test_it_calculates_average_items_per_merchant
    assert_equal 5.0, @analyst.average_items_per_merchant
  end

  def test_it_calculates_standard_deviation
    assert_equal 2.65, @analyst.average_items_per_merchant_standard_deviation
  end
  
  def test_it_returns_merchants_with_high_item_count
    assert_equal [@mer_repo.merchants[2]], @analyst.merchants_with_high_item_count
  end

  def test_it_calculates_average_item_price_for_merchant
    assert_equal BigDecimal(14.88,4), @analyst.average_item_price_for_merchant(12334113)
  end
  
  def test_it_calculates_average_average_price_per_merchant
    assert_equal BigDecimal(14.88,4), @analyst.average_average_price_per_merchant
  end

  def test_it_returns_golden_items
   assert_equal [], @analyst.golden_items
  end

  def test_average_invoices_per_merchant
    assert_equal 5, @analyst.average_invoices_per_merchant
  end

  def test_average_invoices_per_merchant_standard_deviation
    assert_equal 2.65, @analyst.average_items_per_merchant_standard_deviation
  end

  def test_top_merchants_by_invoice_count
    assert_equal [], @analyst.top_merchants_by_invoice_count
  end

  def test_bottom_merchants_by_invoice_count
    assert_equal [], @analyst.bottom_merchants_by_invoice_count
  end

  def test_top_days_by_invoice_count
    assert_equal [], @analyst.top_days_by_invoice_count
  end

  def test_invoice_status
    assert_equal 6.67, @analyst.invoice_status(:pending)
    assert_equal 60, @analyst.invoice_status(:shipped)
    assert_equal 33.33, @analyst.invoice_status(:returned)
  end

  def test_it_returns_total_revenue_by_date
    assert_equal 4499.9, @analyst.total_revenue_by_date("2000-12-10")
  end
  
  def test_it_returns_top_revenue_eraners 
    assert_equal [@mer_repo.merchants[0], @mer_repo.merchants[1]], @analyst.top_revenue_earners(x = 20)
  end
  
end