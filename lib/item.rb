class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at
  def initialize(info)
    @id = info[:id]
    @name = info[:name]
    @description = info[:description]
    @unit_price = info[:unit_price]
    @created_at = info[:created_at]
  end

end
