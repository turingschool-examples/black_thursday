class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id

  def initialize(args)
    @args = args
    @id = args[:id].to_s 
    @name = args[:name].to_s
    @description  = args[:description].to_s
    @unit_price = args[:unit_price].to_s
    @created_at = args[:created_at].to_s
    @updated_at = args[:updated_at].to_s
    @merchant_id = args[:merchant_id].to_s
  end




end
