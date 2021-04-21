require_relative 'sales_engine'
require 'bigdecimal'

class SalesAnalyst
  attr_reader :sales_engine
  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def item_count 
    sales_engine.item_count
  end

  def merchant_count #needed
    sales_engine.merchant_count
  end

  def average_items_per_merchant
    @sales_engine.average_items_per_merchant
  end

  def average_price
    sales_engine.average_price
  end

  def average_items_per_merchant_standard_deviation 
    @sales_engine.average_items_per_merchant_standard_deviation
  end

  def item_count_per_merchant
    sales_engine.item_count_per_merchant
  end

  def merchants_with_high_item_count
    @sales_engine.merchants_with_high_item_count
  end

  def average_item_price_for_merchant(merchant_id)
    @sales_engine.average_item_price_for_merchant(merchant_id)
  end

  def average_item_price_standard_deviation 
    @sales_engine.average_items_per_merchant_standard_deviation
  end

  def average_average_price_per_merchant
    @sales_engine.average_average_price_per_merchant
  end

  def golden_items
    two_deviation = (average_item_price_standard_deviation * 2) + average_price
    sales_engine.all_items.find_all do |item|
      item.unit_price_to_dollars > two_deviation
    end
  end

  def invoice_count #invoice repo
    @sales_engine.invoice_count
  end

  def average_invoices_per_merchant 
    @sales_engine.average_invoices_per_merchant
  end

  def average_invoices_per_merchant_standard_deviation
    @sales_engine.average_invoices_per_merchant_standard_deviation
  end
 
  def invoice_count_per_merchant #invoice_repo
    @sales_engine.invoice_count_per_merchant
  end

  def top_merchants_by_invoice_count
    @sales_engine.top_merchants_by_invoice_count
  end

  def bottom_merchants_by_invoice_count
    @sales_engine.bottom_merchants_by_invoice_count
  end 

  def average_invoice_per_day_standard_deviation
    @sales_engine.average_invoice_per_day_standard_deviation
  end
 
  def invoice_status(status)
    @invoices.invoice_status
  end 

  def invoice_paid_in_full?(id)
     sales_engine.find_all_by_result("success").any? do |transaction|
     transaction.invoice_id.to_i == id
    end
  end

  def invoice_total(id)
    return 0 if !(invoice_paid_in_full?(id))
    total = sales_engine.find_all_by_invoice_id(id).sum do |invoice|
      (invoice.unit_price * invoice.quantity) if  invoice_paid_in_full?(id)
    end
    total.round(2)
  end

  def total_revenue_by_date(date)
    sales_engine.find_all_by_date(date).sum do |invoice|
      invoice_total(invoice.id).round(2)
    end
  end

  def revenue_by_merchant_id
    merchants = Hash.new(0)
    sales_engine.invoices_by_merchant.each do |merchant, invoice|
      merchants[merchant] = invoice.sum do |invoice|
        invoice_total(invoice.id)
      end
    end
    merchants
  end

  def revenue_by_merchant_id
    @merchants.revenue_by_merchant_id
  end


  def top_revenue_earners
    @sales_engine.top_revenue_earners
  end

  def merchants_ranked_by_revenue
    @merchants.merchants_ranked_by_revenue
  end

  def merchants_with_pending_invoices
    @merchants.merchants_ranked_by_revenue
  end

  def merchants_with_only_one_item
    merchants = item_count_per_merchant.map do |merchant, count|
       sales_engine.find_by_id(merchant) if count == 1
  end
   merchants.compact.uniq
  end

 def merchants_with_only_one_item_registered_in_month(month)
   merchants_with_only_one_item.find_all do |merchant|
     merchant.created_at.strftime("%B") == month
   end
 end

 def revenue_by_merchant(merchant_id)
   total = []
   revenue_by_merchant_id.each do |merchant, revenue|
     total << revenue if merchant == merchant_id
   end
   total[0]
 end

 def most_sold_item_for_merchant(merchant_id)
 end

 def best_item_for_merchant(merchant_id)
 end

end
