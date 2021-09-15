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
    (@mr.all).each do |merchant|
      diff = (mean - @ir.find_all_by_merchant_id(merchant.id).length.to_f)
      sum += diff**2
    end
    s_d = Math.sqrt(sum/((@mr.all.length.to_f)-1))
    s_d.round(2)
  end

  def merchants_with_high_item_count
    array = []
    #s_d = self.average_items_per_merchant_standard_deviation
    s_d = 3.26
    mean_item = self.average_items_per_merchant
    one_above_sd = mean_item + s_d

    (@mr.all).each do |merchant|
      if @ir.find_all_by_merchant_id(merchant.id).length > one_above_sd
        array << merchant
      end
    end
    array
  end

  def average_item_price_for_merchant(id)

  end

  def average_average_item_price_for_merchant

  end

  def golden_item

  end

end
