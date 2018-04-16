require "./lib/sales_engine"
require "./lib/calculator"

class SalesAnalyst
    include Calculator
    attr_reader :sales_engine
    def initialize(sales_engine)
        @sales_engine = sales_engine
    end

    def items_per_merchant
       @sales_engine.merchant_repo.merchants.map do |merchant|
            id = merchant.id
            @sales_engine.item_repo.find_all_by_merchant_id(id).length
        end
    end

    def average_items_per_merchant
        num_per_merchant = items_per_merchant
        average = (num_per_merchant.inject(:+) / num_per_merchant.length)
    end

    def top_selling_merchants
        
    end

end
