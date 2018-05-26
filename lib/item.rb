class Item
  attr_reader :created_at, :updated_at
  attr_accessor :name, :description, :unit_price
  
  def initialize(args)
    @name        = args[:name]
    @description = args[:description]
    @unit_price  = args[:unit_price]
    @created_at  = args[:created_at]
    @updated_at  = args[:updated_at]
  end


end
