require 'pry'
require 'bigdecimal'
class Item

    attr_reader :id,
                :name,
                :description,
                :unit_price,
                :merchant_id,
                :created_at,
                :updated_at,
                :parent,
                :downcased_description

    def initialize(data, parent)
        @id = data[:id].to_i
        @name = data[:name]
        @description = data[:description]
        @downcased_description = description.downcase
        @unit_price = BigDecimal.new(data[:unit_price])/100
        @merchant_id = data[:merchant_id].to_i
        @created_at = Time.parse(data[:created_at])
        @updated_at = Time.parse(data[:updated_at])
        @parent = parent
    end

end