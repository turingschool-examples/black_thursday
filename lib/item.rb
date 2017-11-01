require 'csv'

class Item
attr_reader :id,
            :name,
            :description,
            :unit_price,
            :created_at,
            :updated_at,
            :repository,
            :unit_price_to_dollars,
            :merchant_id

  def initialize(data,*parent)
    @id = data[:id]
    @name = data[:name]
    @description = data[:description]
    @unit_price = data[:unit_price]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @unit_price_to_dollars = data[:unit_price_to_dollars]
    @merchant_id = data[:merchant_id]
    @repository = parent
  end

  def merchant
    @repository.merchant(merchant_id)
    # binding.pry
  end

end
