<<<<<<< HEAD
require 'CSV'

class Item
  attr_reader :id, :name, :description, :unit_price, :created_at, :updated_at, :merchant_id

  def initialize(item_attributes)
    @id = item_attributes[:id].to_i
    @name = item_attributes[:name]
    @description = item_attributes[:description]
    @unit_price = item_attributes[:unit_price]
    @created_at = item_attributes[:created_at]
    @updated_at = item_attributes[:updated_at]
    @merchant_id = item_attributes[:merchant_id].to_i
  end
  def unit_price_to_dollars
    @unit_price.to_f
  end
=======
class Item
	attr_reader :id,
							:name,
							:description,
							:unit_price,
							:created_at,
							:updated_at,
							:merchant_id

	def initialize(data)
		@id = data[:id]
		@name = data[:name]
		@description = data[:description]
		@unit_price = data[:unit_price]
		@created_at = data[:created_at]
		@updated_at = data[:updated_at]
		@merchant_id = data[:merchant_id]
	end

	def unit_price_to_dollars
		@unit_price.to_f
	end
>>>>>>> d60f6a0a63a73fa7870db962ee7545ed9f4d505f
end
