require_relative 'sales_engine'

class SalesAnalyst
    attr_reader :sales_engine

    def initialize(sales_engine)
        @sales_engine = sales_engine
    end

    def average_items_per_merchant
        require 'pry'; binding.pry  
        # find_all_by_merchant_id(merchant_id)
        
    end
end