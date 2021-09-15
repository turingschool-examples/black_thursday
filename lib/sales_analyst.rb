require 'csv'

class SalesAnalyst

  attr_reader :sales_engine

  def initialize#(sales_engine)
    # @sales_engine = sales_engine
    @ir = ItemRepository.new('./data/items.csv')
    @mr = MerchantRepository.new('./data/merchants.csv')
  end

  def average_items_per_merchant

    (@ir.all.length.to_f/@mr.all.length.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation


    mean = self.average_items_per_merchant.to_f
    sum = 0.0
    @mr.all.each do |merchant|
      diff = (mean - @ir.find_all_by_merchant_id(merchant.id.to_s).length.to_f)
      sum += diff**2
    end
    s_d = Math.sqrt(sum/((@mr.all.length.to_f)-1))
    s_d.round(2)
  end

  def merchants_with_high_item_count
    mer_array = []
    mean_item = average_items_per_merchant
    s_d = average_items_per_merchant_standard_deviation
    one_above_sd = mean_item + s_d

    @mr.all.each do |merchant|
      if @ir.find_all_by_merchant_id(merchant.id.to_s).length > one_above_sd
        mer_array << merchant
      end
    end
    mer_array
  end

  def average_item_price_for_merchant(id)
    items_by_a_mr = @ir.find_all_by_merchant_id(id.to_s)
    num_of_items = items_by_a_mr.length.to_f
    total_price_item = 0.0

    items_by_a_mr.each do |item|
      total_price_item += item.unit_price
    end

    average = total_price_item.to_f/num_of_items
  end

  def average_average_item_price_for_merchant
    total = 0
    @mr.all.each do |merchant|
      total += average_item_price_for_merchant(merchant.id.to_s)
    end
    average = total/@mr.all.length.to_f
  end

  def golden_item

  end

end
