require 'csv'
require 'bigdecimal'
require 'bigdecimal/util'

class Item
attr_reader :id,
            :name,
            :description,
            :unit_price,
            :created_at,
            :updated_at,
            :repository,
            :merchant_id
            # :unit_price_to_dollars

  def initialize(data, parent = nil)
    @id = data[:id]
    @name = data[:name]
    @description = data[:description]
    @unit_price = BigDecimal.new(data[:unit_price])
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @merchant_id = data[:merchant_id]
    @repository = parent
  end

  def merchant
    @repository.find_merchant_by_id(@merchant_id)
    # binding.pry
  end

def unit_price_to_dollars
  unit_price.to_s("F").to_f
end

end
