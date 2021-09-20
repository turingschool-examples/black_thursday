require 'csv'
require_relative 'merchantrepository'
require_relative 'itemrepository'
require_relative 'sales_engine'

class SalesAnalyst < SalesEngine

  @@se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
  })

  def initialize
  end

  def average_items_per_merchant
    ir = @@se.items
    mr = @@se.merchants

    ((ir.all.count.to_f) / (mr.all.count.to_f)).round(2)
  end

  def average_items_per_merchant_standard_deviation
    ir = @@se.items
    mr = @@se.merchants
    item_set = mr.all.map do |merchant|
      ir.find_all_by_merchant_id(merchant.id).count
    end

    num = 0.0

    item_set.map do |item|

      num += ((item - average_items_per_merchant)**2)

    end
    sd = (num / (mr.all.count - 1))
    Math.sqrt(sd).round(2)
  end

  def merchants_with_high_item_count

    ir = @@se.items
    mr = @@se.merchants

    item_set = mr.all.map do |merchant|
      ir.find_all_by_merchant_id(merchant.id)
    end

    high_items = item_set.find_all do |ipm|
       ipm.count > (average_items_per_merchant + average_items_per_merchant_standard_deviation)
    end

    high_merchants = high_items.map do |items|
      mr.find_by_id(items[0].merchant_id)
    end
    high_merchants
  end

  def average_item_price_for_merchant(merchant_id)
    ir = @@se.items

    merchant_items = ir.find_all_by_merchant_id(merchant_id)
    total_price = 0.0

    merchant_items.each do |item|
      total_price += item.unit_price.to_f
    end

    (total_price / merchant_items.count).to_d
  end

  def average_average_price_per_merchant
    ir = @@se.items
    mr = @@se.merchants

    sum = mr.all.map do |merchant|
      average_item_price_for_merchant(merchant.id).to_f
    end

    pun = sum.sum do |num|
      num
    end
    (pun / mr.all.count).to_d

  end

  def golden_items
    # need to check the g_threshold to make sure it is correct number.
    ir = @@se.items
    aappm = average_average_price_per_merchant
    price_set = ir.all.map do |item|
      item.unit_price.to_f
    end

    num = 0.0

    price_set.map do |price|

      num += ((price - aappm)**2)

    end
    x = (num / (ir.all.count - 1))
    std_dev = Math.sqrt(x).round(2)

    g_threshold = (std_dev*2) + aappm.to_f

    ir.find_all_by_price_in_range(g_threshold, Float::INFINITY)
  end

  def average_invoices_per_merchant
    inr = @@se.invoices
    mr = @@se.merchants

    ((inr.all.count.to_f) / (mr.all.count.to_f)).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    inr = @@se.invoices
    mr = @@se.merchants
    invoice_set = mr.all.map do |merchant|
      inr.find_all_by_merchant_id(merchant.id).count
    end

    num = 0.0

    invoice_set.map do |invoice|

      num += ((invoice - average_invoices_per_merchant)**2)

    end
    sd = (num / (mr.all.count - 1))
    Math.sqrt(sd).round(2)

  end

  def top_merchants_by_invoice_count
    #need to finish golden items, then transport that code here.
  end

  def bottom_merchants_by_invoice_count
    #need to finish golden items, then transport that code here.
  end

  def top_days_by_invoice_count
    #need to finish golden items, then transport that code here.
  end

  def invoice_status(status)
    inr = @@se.invoices

    (((inr.find_all_by_status(status).count) / ((inr.all.count).to_f)) * 100).round(2)
  end

end
