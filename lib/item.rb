class Item

  attr_reader :id, :merchant_id, :created_at
  attr_accessor :name, :description, :unit_price, :updated_at

  def initialize(info)
    @id = info[:id].to_i
    @name = info[:name]
    @description = info[:description]
    @unit_price = info[:unit_price].to_f.round(2)
    @merchant_id = info[:merchant_id].to_i
    @created_at = Time.parse(info[:created_at])
    @updated_at = Time.parse(info[:updated_at])
  end

  def unit_price_to_dollars
    @unit_price
  end

end
