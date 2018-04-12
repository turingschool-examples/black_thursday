require_relative "sales_engine"

 def item_counts_for_all_merchants
    merchants.repository.map { |merchant| merchant.items.length }
  end

class SalesAnalyst
    def items_per_merchant
        sales_engine.merchants.repository.map do |merchant|
            merchant.items.length
        end
    end

    def average_items_per_merchant
        num_per_merchant = items_per_merchant
        average = (num_per_merchant.inject(:+) / num_per_merchant.length)
    end
end
