class Item
  attr_reader :name, :description, :unit_price, :created_at, :updated_at, :id,
              :merchant_id

  def initialize(properties = Hash.new)
    @id =           properties[:id]
    @name =         properties[:name]
    @description =  properties[:description]
    @unit_price =   properties[:unit_price]
    @created_at =   properties[:created_at]
    @updated_at =   properties[:updated_at]
    @merchant_id =  properties[:merchant_id]
  end

end
