require 'csv'
require_relative 'sales_engine'
require 'bigdecimal'



class SalesAnalyst



  def initialize(repos)

    @items = repos[:items]
    @merchants = repos[:merchants]

  end

  def average_items_per_merchant

    (@items.all.length.to_f/@merchants.all.length.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation


    mean = self.average_items_per_merchant.to_f
    sum = 0.0
    @merchants.all.each do |merchant|
      diff = (mean - @items.find_all_by_merchant_id(merchant.id).length.to_f)
      sum += diff**2
    end
    s_d = Math.sqrt(sum/((@merchants.all.length.to_f)-1))
    s_d.round(2)
  end

  def merchants_with_high_item_count
    mer_array = []
    mean_item = average_items_per_merchant
    s_d = average_items_per_merchant_standard_deviation
    one_above_sd = mean_item + s_d

    @merchants.all.each do |merchant|
      if @items.find_all_by_merchant_id(merchant.id).length > one_above_sd
        mer_array << merchant
      end
    end
    mer_array
  end

  def average_item_price_for_merchant(id)
    items_by_a_mr = @items.find_all_by_merchant_id(id)
    num_of_items = items_by_a_mr.length.to_f
    total_price_item = 0.0

    items_by_a_mr.each do |item|
      total_price_item += item.unit_price
    end

    average = BigDecimal((total_price_item/num_of_items).round(2))
  end

  def average_average_price_per_merchant
    total = 0
    @merchants.all.each do |merchant|
      total += average_item_price_for_merchant(merchant.id)
    end
    average = (total/@merchants.all.length.to_f).round(2)
  end

  def average_price_standard_deviation
    mean = average_average_price_per_merchant
    item_count = (@items.all.length.to_f - 1).to_f
    sum = 0.0
    @items.all.each do |item|
      diff = (mean - item.unit_price.to_f)
      sum += diff**2
    end
    s_d = Math.sqrt((sum)/item_count)
    s_d.round(2)
  end


  def golden_items
    array_gold_item = []
    two_s_d = average_price_standard_deviation * 2

    @items.all.each do |item|
      if item.unit_price > two_s_d
        array_gold_item << item
      end
    end
    array_gold_item

  end

end
