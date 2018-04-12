# frozen_string_literal: true

class SalesAnalyst

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def all_items_per_merchant
    @sales_engine.items.all.group_by{|item| item.merchant_id}
  end

  def average_items_per_merchant
    item_count = all_items_per_merchant.values.map{|merch_items| merch_items.count}
    item_sum = item_count.inject(0){|sum, number| sum + number}
    (item_sum.to_f / all_items_per_merchant.values.count).round(2)
  end







end
