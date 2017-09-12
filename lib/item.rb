class Item
attr_reader :name,
            :description,
            :unit_price,
            :created_at,
            :updated_at,
            :merchant_id

    def initialize(info = {})
      @name = info[:name]
      @description = info[:description]
      @unit_price = info[:unit_price]
      @created_at = info[:created_at]
      @updated_at = info[:updated_at]
      @merchant_id = info[:merchant_id]
    end

end
