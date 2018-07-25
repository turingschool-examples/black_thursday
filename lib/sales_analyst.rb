require_relative './sales_engine'

class SalesAnalyst

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    (find_number_of_items.to_f / find_number_of_merchants).round(2)
  end

  def group_items_by_merchant
    @sales_engine.items.all.group_by(&:merchant_id)
  end

  def find_number_of_merchants
    group_items_by_merchant.inject(0) do |count, (id, items)|
      count + 1
    end
  end

  def find_number_of_items
    group_items_by_merchant.inject(0) do |count, (id, items)|
      count + items.count
    end
  end

end
