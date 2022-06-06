require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'item'
require_relative 'merchant'
require_relative 'invoice'
require_relative 'sales_engine'
require 'bigdecimal'
require 'pry'
class SalesAnalyst < SalesEngine

  def initialize(items_path,merchants_path, invoice_path)
    super
  end

  def average_items_per_merchant
    (@items.all.count / @merchants.all.count.to_f).round(2)
  end

#helper method for average_item_price_for_merchant
  def count_merchants_items(id)
    @items.find_all_by_merchant_id(id).count
  end

#helper method for average_item_price_for_merchant
  def price_array(id)
    @items.find_all_by_merchant_id(id).map do |item|
     item.unit_price_to_dollars
    end
  end

  def average_item_price_for_merchant(id)
    BigDecimal((price_array(id).sum/count_merchants_items(id)).round(2).to_s)
  end

  def average_items_per_merchant_standard_deviation
    item_count = @merchants.all.map do |merchant|
      @items.find_all_by_merchant_id(merchant.id).length
    end
    standard_deviation(item_count, average_items_per_merchant)
  end

  def standard_deviation(counts, average)
    total_sum = counts.sum do |count|
      (count - average)**2
    end

    Math.sqrt(total_sum / (counts.length - 1)).round(2)
  end

  def merchants_with_high_item_count
    high_item_count = average_items_per_merchant + average_items_per_merchant_standard_deviation
    @merchants.all.find_all {|merchant| @items.find_all_by_merchant_id(merchant.id).length > high_item_count}
  end

  def golden_items
    item_list = @items.all.map{|item| item.unit_price}
    price_sum = @items.all.sum{|item| item.unit_price}
    average = price_sum / @items.all.length
    sd = standard_deviation(item_list, average)

    @items.all.find_all{|item| item.unit_price > (average + (sd * 2))}
  end

  def average_average_price_per_merchant
  all_merchants = []
  @merchants.all.each {|merchant| all_merchants << merchant.id}
  unique_merchants = all_merchants.uniq.count
  all_merchants.map! {|merchant_id| average_item_price_for_merchant(merchant_id)}
  BigDecimal((all_merchants.sum / unique_merchants).round(2).to_s)
  end

# Business intelligence starts here
  def average_invoices_per_merchant
    (@invoices.all.count / @merchants.all.count.to_f).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    invoice_count = @merchants.all.map do |merchant|
      @invoices.find_all_by_merchant_id(merchant.id).length
    end
    standard_deviation(invoice_count, average_invoices_per_merchant)
  end

  def top_merchants_by_invoice_count
    invoice_count = average_invoices_per_merchant + (average_invoices_per_merchant_standard_deviation * 2)
    @merchants.all.find_all {|merchant| @invoices.find_all_by_merchant_id(merchant.id).length > invoice_count}
  end

  def bottom_merchants_by_invoice_count
    invoice_count = average_invoices_per_merchant - (average_invoices_per_merchant_standard_deviation * 2)
    @merchants.all.find_all {|merchant| @invoices.find_all_by_merchant_id(merchant.id).length < invoice_count} #we are very unsure about this line- For this method we need to find two standard deviations below the mean _ and we are not sure this accomplishes that
  end

  def date_formatter
    date = Date.new(invoices.created_at)
    date.strftime("%A")
  end

  def invoices_per_weekday
    invoice_count = {'Monday' => 0,'Tuesday' => 0,'Wednesday' => 0,'Thursday' => 0,'Friday' => 0,'Saturday' => 0,'Sunday' => 0,}
   @invoices.all.each do |invoice|
      invoice_count[invoice.created_at.strftime("%A")] += 1
    end
    invoice_count
  end

  def average_invoices_per_weekday
    (invoices_per_weekday.values.sum) / 7
  end

  def top_days_by_invoice_count
    invoice_count = average_invoices_per_weekday + standard_deviation(invoices_per_weekday.values, average_invoices_per_weekday)
    top_days = invoices_per_weekday.find_all{|weekday, count| count > invoice_count}.map{|days| days[0]}
  end

  def invoice_status(tracking)
    total_invoices = @invoices.all.length
    (@invoices.find_all_by_status(tracking).length * 100.0 / total_invoices).round(2)
  end
end
