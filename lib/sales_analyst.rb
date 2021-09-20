require 'csv'
require './lib/merchantrepository'
require './lib/itemrepository'
require './lib/sales_engine'

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
    (pun / ir.all.count).to_d
  end

  def golden_items
    ir = @@se.items

    price_set = ir.all.map do |item|
      item.unit_price.to_f
    end

    num = 0.0

    price_set.map do |price|

      num += ((price - average_average_price_per_merchant)**2)

    end
    sd = (num / (ir.all.count - 1))
    Math.sqrt(sd).round(2)

  end

end
