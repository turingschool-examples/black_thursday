class Item
attr_reader :name,
            :description,
            :unit_price,
            :created_at,
            :updated_at,
            :merchant_id,
            :id
attr_accessor :merchant

    def initialize(info, item_repository = 'string')
      @id = info[:id]
      @name = info[:name]
      @description = info[:description]
      @unit_price = info[:unit_price].to_f
      @created_at = info[:created_at]
      @updated_at = info[:updated_at]
      @merchant_id = info[:merchant_id]
      @item_repository = item_repository
      @merchant = ''
    end

    # def gather_merchant
    #   @merchant = @sales_engine.merchants.find_by_id(@merchant_id)      
    # end

    def merchant
      @item_repository.sales_engine.merchants.find_by_id(@merchant_id)
    end 
end
