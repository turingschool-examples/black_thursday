class Item


  attr_reader :id, :created_at, :updated_at, :merchant_id
  attr_accessor :name, :description, :unit_price

  def initialize(data)
    @id           = data[:id]
    @name         = data[:name]
    @description  = data[:description]
    @unit_price   = data[:unit_price]
    @created_at   = data[:created_at]
    @updated_at   = data[:updated_at]
    @merchant_id  = data[:merchant_id]
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def unit_price_to_bigdecimal
    @unit_price.to_d
  end

  def id_to_string
    @id.to_s
  end

  def merchant_id_to_int
    @merchant_id.to_i
  end

  def string_to_time
    @updated_at.to_datetime
    @created_at.to_datetime
  end

end
