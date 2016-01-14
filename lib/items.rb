require 'pry'

class Items
  attr_accessor :id, :name, :description, :unit_price, :created_at, :updated_at, :merchant_id

  def initialize(args_hash)
    @id = args_hash[:id].to_i
    @name = args_hash[:name]
    @description = args_hash[:description]
    @unit_price = args_hash[:unit_price]
    @created_at = args_hash[:created_at]
    @updated_at = args_hash[:updated_at]
    @merchant_id = args_hash[:merchant_id]
  end

end
