require_relative 'maths'

class SalesAnalyst
  include Maths
  attr_reader :se

  def initialize(parent)
    @se = parent
    @average_items_per_merchant = 0
    @items_std = 0
  end

  def average_items_per_merchant
    avg = @se.items.all.count.to_f / @se.merchants.all.count
    @average_items_per_merchant = avg.round(2)
  end

  def average_items_per_merchant_standard_deviation
    merchant_stock = @se.items.all.group_by do |item|
      item.merchant_id
    end
    @totals = merchant_stock.map do |merchant, items|
      [items.count.to_d]
    end
    @items_std = standard_deviation(@totals.flatten)
  end

  def average_invoices_per_merchant
    total_merchants = @se.merchants.all.count
    total_invoices = @se.invoices.all.count
    BigDecimal((total_invoices/total_merchants), 3)
  end

  def merchants_with_high_item_count
    cutoff = @average_items_per_merchant + @items_std
    high_count = @totals.find_all do |grouping|
      require "pry"; binding.pry
      grouping.count > cutoff
    end
  end
end
