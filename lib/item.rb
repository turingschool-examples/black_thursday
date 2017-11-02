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
            # :unit_price_to_dollars,
            :merchant_id

  def initialize(data, parent=nil)
    @id = data[:id]
    @name = data[:name]
    @description = data[:description]
    @unit_price = BigDecimal.new(data[:unit_price])
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    # @unit_price_to_dollars = data[:unit_price_to_dollars]
    @merchant_id = data[:merchant_id]
    @repository = parent
  end

  # def merchant
  #   @repository.merchant(merchant_id)
  #   # binding.pry
  # end

  def merchant
    repository.find_merchant_by_id(self.merchant_id)
  end

  def unit_price_to_dollars
    @unit_price.truncate(2).to_f
    # require "pry"; binding.pry
  end

end
