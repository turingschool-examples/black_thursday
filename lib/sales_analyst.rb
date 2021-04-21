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

  # def average_item_price_for_merchant(merchant_id) #item repo
  #   all_items = sales_engine.find_all_by_merchant_id(merchant_id)
  #   sum = all_items.sum do |item|
  #     item.unit_price
  #   end
  #   (sum / all_items.length).round(2)
  # end

  def average_item_price_for_merchant(merchant_id)
    @sales_engine.average_item_price_for_merchant(merchant_id)
  end

  def average_item_price_standard_deviation 
    @sales_engine.average_items_per_merchant_standard_deviation
  end

  # def average_average_price_per_merchant # merchant repo
  #   all_items = item_count_per_merchant.length
  #   all_averages = sales_engine.all_merchants.sum do |merchant|
  #     average_item_price_for_merchant(merchant.id)
  #   end

  #   (all_averages / all_items).round(2)
  # end
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

#  def average_invoices_per_merchant_standard_deviation #invoice repo
#    average_invoice = average_invoices_per_merchant
#    sum = sales_engine.invoice_count_per_merchant.sum do |invoice, count|
#      (average_invoice - count)**2
#    end
#    sum = (sum / (merchant_count - 1))
#    (sum ** 0.5).round(2)
#  end

  def average_invoices_per_merchant_standard_deviation
    @sales_engine.average_invoices_per_merchant_standard_deviation
  end
 
  def invoice_count_per_merchant #invoice_repo
    @sales_engine.invoice_count_per_merchant
  end

#  def top_merchants_by_invoice_count #
#    two_deviation = (average_items_per_merchant_standard_deviation * 2) + average_invoices_per_merchant
#    high_merchants = []
#    invoice_count_per_merchant.find_all do |id, count|
#      high_merchants << sales_engine.find_by_id(id) if count > two_deviation
#    end
#    high_merchants
#  end

  def top_merchants_by_invoice_count
    @invoices.top_merchants_by_invoice_count
  end

 def bottom_merchants_by_invoice_count
   two_deviation = average_invoices_per_merchant - (average_items_per_merchant_standard_deviation * 2)
   low_merchants = []
   invoice_count_per_merchant.find_all do |id, count|
     low_merchants << sales_engine.find_by_id(id) if count < two_deviation
   end
   low_merchants
 end

 def average_invoice_per_day_standard_deviation
   average_per_day = invoice_count / 7
   sum = sales_engine.invoice_count_per_day.sum do |invoice, count|
     (average_per_day - count)**2
   end
   sum = (sum / (7 - 1))
   (sum ** 0.5).round(2)
 end

 def top_days_by_invoice_count
   one_deviation = (invoice_count / 7) + average_invoice_per_day_standard_deviation
   top_days = []
   sales_engine.invoice_count_per_day.find_all do |day, count|
     top_days << day if count > one_deviation
   end
   top_days
 end

 def invoice_status(status)
   ((sales_engine.find_all_by_status(status).length / invoice_count) * 100).round(2)
 end

 def invoice_paid_in_full?(id)
   sales_engine.find_all_by_result("success").any? do |transaction|
     transaction.invoice_id.to_i == id
   end
 end

 def invoice_total(id)
   return 0 if !(invoice_paid_in_full?(id))
   total = sales_engine.find_all_by_invoice_id(id).sum do |invoice|
     (invoice.unit_price * invoice.quantity) if invoice_paid_in_full?(id)
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

 def top_revenue_earners(x = 20)
   descending = revenue_by_merchant_id.sort_by do |merchant_id|
      merchant_id[1]
    end.reverse
    high_merchants = descending[0...x]
    high_merchants.map do |merchant|
      sales_engine.find_by_id(merchant[0])
    end
 end

 def merchants_ranked_by_revenue
   descending = revenue_by_merchant_id.sort_by do |merchant_id|
      merchant_id[1]
    end.reverse
   descending.map do |merchant|
     sales_engine.find_by_id(merchant[0])
   end
 end

 def merchants_with_pending_invoices
   merchants = sales_engine.find_all_pending.map do |invoice|
     sales_engine.find_by_id(invoice.merchant_id) if invoice_paid_in_full?(invoice.id) == false
   end
   merchants.compact.uniq
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
