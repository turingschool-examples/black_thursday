require 'csv'
require_relative 'merchantrepository'
require_relative 'itemrepository'
require_relative 'sales_engine'

class SalesAnalyst < SalesEngine

  # @@se = SalesEngine.from_csv({
  #   :items     => "./data/items.csv",
  #   :merchants => "./data/merchants.csv",
  # })

  def initialize(items, merchants, invoices, invoice_items, transactions)
    @ir = items
    @mr = merchants
    @inr = invoices
    @inv_items = invoice_items
    @tran = transactions
  end

  def average_items_per_merchant
    ((@ir.all.count.to_f) / (@mr.all.count.to_f)).round(2)
  end

  def average_items_per_merchant_standard_deviation
    item_set = @mr.all.map do |merchant|
      @ir.find_all_by_merchant_id(merchant.id).count
    end
    num = 0.0
    item_set.map do |item|
      num += ((item - average_items_per_merchant)**2)
    end
    sd = (num / (mr.all.count - 1))
    Math.sqrt(sd).round(2)
  end

  def merchants_with_high_item_count
    aipm = average_items_per_merchant
    aipmsd = average_items_per_merchant_standard_deviation
    item_set = mr.all.map do |merchant|
      @ir.find_all_by_merchant_id(merchant.id)
    end
    high_items = item_set.find_all do |ipm|
       ipm.count > (aipm + aipmsd)
    end
    high_merchants = high_items.map do |items|
      @mr.find_by_id(items[0].merchant_id)
    end
    high_merchants
  end

  def average_item_price_for_merchant(merchant_id)
    merchant_items = @ir.find_all_by_merchant_id(merchant_id)
    total_price = 0.0
    merchant_items.each do |item|
      total_price += item.unit_price.to_f
    end
    (total_price / merchant_items.count).to_d
  end

  def average_average_price_per_merchant
    sum = @mr.all.map do |merchant|
      average_item_price_for_merchant(merchant.id).to_f
    end
    pun = sum.sum do |num|
      num
    end
    (pun / @mr.all.count).to_d
  end

  def golden_items
    aappm = average_average_price_per_merchant
    price_set = @ir.all.map do |item|
      item.unit_price.to_f
    end
    num = 0.0
    price_set.map do |price|
      num += ((price - aappm)**2)
    end
    x = (num / (@ir.all.count - 1))
    std_dev = Math.sqrt(x).round(2)
    g_threshold = (std_dev*2) + aappm.to_f
    @ir.find_all_by_price_in_range(g_threshold, Float::INFINITY)
  end

  def average_invoices_per_merchant
    ((@inr.all.count.to_f) / (@mr.all.count.to_f)).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    invoice_set = @mr.all.map do |merchant|
      @inr.find_all_by_merchant_id(merchant.id).count
    end
    num = 0.0
    invoice_set.map do |invoice|
      num += ((invoice - average_invoices_per_merchant)**2)
    end
    sd = (num / (@mr.all.count - 1))
    Math.sqrt(sd).round(2)
  end

  def top_merchants_by_invoice_count
    aipm = average_invoices_per_merchant
    aipmsd = average_invoices_per_merchant_standard_deviation
    item_set = @mr.all.map do |merchant|
      @ir.find_all_by_merchant_id(merchant.id)
    end
    high_items = item_set.find_all do |ipm|
       ipm.count > (aipm + (aipmsd*2))
    end
    high_merchants = high_items.map do |items|
      @mr.find_by_id(items[0].merchant_id)
    end
    high_merchants
  end

  def bottom_merchants_by_invoice_count
    aipm = average_invoices_per_merchant
    aipmsd = average_invoices_per_merchant_standard_deviation
    item_set = mr.all.map do |merchant|
      @ir.find_all_by_merchant_id(merchant.id)
    end
    high_items = item_set.find_all do |ipm|
       ipm.count < (aipm - (aipmsd*2))
    end
    bottom_merchants = high_items.map do |items|
      @mr.find_by_id(items[0].merchant_id)
    end
    bottom_merchants
  end

  def invoices_per_day
    ipd = Hash.new(0)
    ipd = @inr.all.group_by do |invoice|
      Date.parse(invoice.created_at).cwday
    end
    ipd["Monday"] = ipd.delete(1)
    ipd["Tuesday"] = ipd.delete(2)
    ipd["Wednesday"] = ipd.delete(3)
    ipd["Thursday"] = ipd.delete(4)
    ipd["Friday"] = ipd.delete(5)
    ipd["Saturday"] = ipd.delete(6)
    ipd["Sunday"] = ipd.delete(7)
    ipd

  end

def invoices_per_day_count
  x = Hash.new(0)
  invoices_per_day.each_key do |day|
    x[day] = invoices_per_day[day].count
  end
  x
end
  # def average_invoices_per_day_of_week
  #   ir = @@se.items
  #   mr = @@se.merchants
  #   inr = @@se.invoices
  #   average_invoices_per_day = Hash.new(0)
  #   average_invoices_per_day["Monday"] = (inr.all.count.to_f / invoices_per_day["Monday"].count)
  #   average_invoices_per_day["Tuesday"] = (inr.all.count.to_f / invoices_per_day["Tuesday"].count)
  #   average_invoices_per_day["Wednesday"] = (inr.all.count.to_f / invoices_per_day["Wednesday"].count)
  #   average_invoices_per_day["Thursday"] = (inr.all.count.to_f / invoices_per_day["Thursday"].count)
  #   average_invoices_per_day["Friday"] = (inr.all.count.to_f / invoices_per_day["Friday"].count)
  #   average_invoices_per_day["Saturday"] = (inr.all.count.to_f / invoices_per_day["Saturday"].count)
  #   average_invoices_per_day["Sunday"] = (inr.all.count.to_f / invoices_per_day["Sunday"].count)
  #
  #   average_invoices_per_day
  # end

  def average_invoices_per_day
    ((@inr.all.count.to_f)/7).round(2)
  end

  def average_invoices_per_day_standard_deviation
    num = 0.0
    invoices_per_day.each_key do |day|

      num += ((invoices_per_day[day].count - average_invoices_per_day)**2)
    end
    sd = (num / (@inr.all.count - 1))
    Math.sqrt(sd).round(2)
  end

  def top_days_by_invoice_count
    #need to finish golden items, then transport that code here.

    high_days = invoices_per_day.filter do |day, value|

      invoices_per_day[day].count > average_invoices_per_day_standard_deviation + average_invoices_per_day

    end
    high_days.each_key do |day|
      high_days[day] = high_days[day].count
    end.keys

  end

  def invoice_status(status)
    (((@inr.find_all_by_status(status).count) / ((@inr.all.count).to_f)) * 100).round(2)
  end

  def invoice_paid_in_full?(invoice_id)
    tran.find_all_by_invoice_id(invoice_id).include?("success")
  end

  def invoice_total(invoice_id)
    inv_item.find_all_by_invoice_id(invoice_id).map {|item| item.unit_price}.sum
  end
end
