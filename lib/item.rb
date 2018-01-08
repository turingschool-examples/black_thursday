require "bigdecimal"

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id,
              :item_repo

  def initialize(row, item_repo)
    @id          = row[:id]
    @name        = row[:name]
    @description = row[:description]
    @unit_price  = (BigDecimal.new(row[:unit_price])) / 100.00
    @created_at  = Time.parse(row[:created_at])
    @updated_at  = Time.parse(row[:updated_at])
    @merchant_id = row[:merchant_id]
    @item_repo   = item_repo
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

  def merchant
    item_repo.find_merchant(self.merchant_id)
  end
end
