class Item

  attr_reader :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at

  def initialize(info)
    @id = info[:id]
    @name = info[:name]
    @description = info[:description]
    @unit_price = info[:unit_price]
    @merchant_id = info[:merchant_id]
    @created_at = info[:created_at]
    @updated_at = info[:updated_at]
  end


end
