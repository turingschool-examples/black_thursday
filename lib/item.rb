# class item takes a hash and has attribute readers for :name, :description, :unit_price, :created_at, :updated_at
class Item
  attr_reader :name, :description, :unit_price, :created_at, :updated_at

  def initialize(data)
    @created_at = data[:created_at]
    @description = data[:description]
    @id = data[:id]
    @name = data[:name]
    @unit_price = data[:unit_price]
    @updated_at = data[:updated_at]
  end
end
