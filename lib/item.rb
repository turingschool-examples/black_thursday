class Item
attr_reader :name,
            :description,
            :unit_price,
            :created_at,
            :updated_at,
            :merchant_id,
            :id
attr_accessor :merchant

    def initialize(info, sales_engine)
      @id = info[:id]
      @name = info[:name]
      @description = info[:description]
      @unit_price = info[:unit_price].to_f
      @created_at = info[:created_at]
      @updated_at = info[:updated_at]
      @merchant_id = info[:merchant_id]
      @sales_engine = sales_engine
      @merchant = ''
    end

    def gather_merchant
      @merchant = @sales_engine.merchants.find_by_id(@merchant_id)
    end

end
