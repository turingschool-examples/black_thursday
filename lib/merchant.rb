require 'bigdecimal'

class Merchant
  attr_reader :id,
              :name

  def initialize(data, parent)
    @id = data[:id]
    @name = data[:name]
    @merchant_repository = parent
  end

  def items
    @merchant_repository.find_items_by_id(@id)
  end

  def average_item_price
    sum_prices = items.reduce(0) do |total, item|
      total + item.unit_price
    end
    return (sum_prices / items.count).round(2)
  end

  def invoices
    @merchant_repository.find_invoices_by_id(@id)
  end
end
