require 'BigDecimal'

class Item
    attr_reader :id,
                :created_at,
                :updated_at,
                :merchant_id
    attr_accessor :description,
                  :name,
                  :unit_price

    def initialize(data)
        @id = data[:id].to_i
        @name = data[:name]
        @description = data[:description]
        @unit_price = data[:unit_price].to_f
        @created_at = data[:created_at]
        @updated_at = data[:updated_at]
        @merchant_id = data[:merchant_id].to_i
    end

    def unit_price_to_dollars
      @unit_price
    end

end
