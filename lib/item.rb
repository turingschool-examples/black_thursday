require 'bigdecimal'

class Item

  attr_reader :name, :repository,
              :merchant_id, :item_id,
              :description, :unit_price,
              :created_at, :updated_at

  def initialize(data, repository)
    @name = data[:name]
    @merchant_id = data[:merchant_id]
    @item_id = data[:id]
    @description = data[:description]
    @unit_price = BigDecimal.new(data[:unit_price])
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @repository = repository
  end

  def merchant
    repository.merchant(merchant_id)
  end

  def unit_price_to_dollars
    @unit_price / 100.00
  end

end
