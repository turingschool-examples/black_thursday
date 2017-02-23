class Item
  attr_reader :id, :name, :description, :unit_price

  def initialize(row, parent =nil)
    @id           = row[:id].to_i
    @name         = row[:name]
    @description  = row[:description]
    @unit_price   = row[:unit_price].to_i / 100.00
    @updated_at   = row[:updated_at]
    @merchant_id  = row[:merchant_id]
  end
end
