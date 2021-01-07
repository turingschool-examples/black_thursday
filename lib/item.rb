class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id

  def initialize(args)
    @args        = args
    @id          = args[:id].to_s
    @name        = args[:name].to_s
    @description = args[:description].to_s
    @unit_price  = args[:unit_price].to_s
    @created_at  = args[:created_at].to_s
    @updated_at  = args[:updated_at].to_s
    @merchant_id = args[:merchant_id].to_s
  end

  def update(args)

    @unit_price  = args[:unit_price].to_f.to_s if !args[:unit_price].nil?
    @description = args[:description].to_s if !args[:description].nil?
    @name        = args[:name].to_s  if !args[:name].nil?
    @updated_at  = Time.new.to_s
  end




end
