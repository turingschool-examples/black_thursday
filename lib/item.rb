require 'bigdecimal'
require 'date'
class Item
    attr_reader :id,
                :name,
                :description,
                :unit_price,
                :created_at,
                :updated_at,
                :merchant_id

    def initialize(hash)
        @id = hash[:id].to_i
        @name = hash[:name]
        @description = hash[:description]
        @unit_price = BigDecimal(hash[:unit_price])
        @created_at = DateTime.parse(hash[:created_at])
        @updated_at = DateTime.parse(hash[:updated_at])
        @merchant_id = hash[:merchant_id].to_i
    end
end
