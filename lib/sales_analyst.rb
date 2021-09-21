# frozen_string_literal: true
require 'BigDecimal'

# SalesAnalyst class creates handles all analysis of merch, items, and invoices

class SalesAnalyst
  attr_reader :items,
              :merchants,
              :invoices,
              :merch_item_hash

  def initialize(items, merchants, invoices)
    @items = items.all
    @merchants = merchants.all
    @invoices = invoices.all
    @merch_item_hash = hash_create
  end

  def hash_create
    return_hash = {}
    @merchants.each do |merchant|
      @items.each do |item|
        if merchant.id == item.merchant_id
          if return_hash[merchant.name].nil?
            return_hash[merchant.name] = [item]
          else
            return_hash[merchant.name] += [item]
          end
        end
      end
    end
    return_hash
  end

  def average_items_per_merchant
    (@items.length.to_f / @merchants.length.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    sum_diff = 0
    @merch_item_hash.each do |merchant, items|
      sum_diff += 1
    end
    sum_diff
  end

  def merchants_with_high_item_count
    return_array = []
    @merch_item_hash.each do |merchant,items|
      if items.length >= (average_items_per_merchant_standard_deviation + average_items_per_merchant)
        return_array.push(merchant)
      end
    end
    return_array
  end

  def average_item_price_for_merchant(merchant_id)
    sum_amount = 0
    num_items = 0
    @items.each do |item|
      if item.merchant_id == merchant_id.to_s
        sum_amount += item.unit_price.to_f
        num_items += 1.to_f
      end
    end
    BigDecimal(sum_amount / num_items, 2)
  end

  def average_average_item_price_for_merchant
    sum_price = 0
    avg_price_array.each { |avg_price| sum_price += avg_price }
    BigDecimal(sum_price.to_f / @merchants.length.to_f, 2)
  end

  def avg_price_array
    return_array = []
    @merch_item_hash.each do |merchant, items|
      total_price = 0
      item_count = items.length.to_f
      items.each do |item|
          total_price += item.unit_price.to_f
      end
      return_array.push(total_price.to_f / item_count.to_f)
    end
    return_array
  end

  def average_price_all
    num_items = @items.length
    items_price = 0
    @items.each do |item|
      items_price += item.unit_price.to_f
    end
    (items_price / num_items.to_f).round(2)
  end

  def average_price_standard_deviation
    sum_diff_squared = 0
    avg = average_price_all
    @items.each do |item|
      sum_diff_squared += ((item.unit_price.to_f - avg)**2)
    end
    ((sum_diff_squared / items.length.to_f)**0.5).round(2)
  end

  def golden_items
    result_array = []
    expected = (average_price_all + (average_price_standard_deviation * 2))
    @items.each do |item|
      result_array.append(item) if item.unit_price.to_f >= expected
    end
  end
end
