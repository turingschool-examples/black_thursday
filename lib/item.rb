class Item
  attr_reader :id, :name, :description, :unit_price
  def initialize(info)
    @id = info[:id]
    @name = info[:name]
    @description = info[:description]
    @unit_price = info[:unit_price]
  end

end
