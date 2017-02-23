require'bigdecimal'
class Item
	attr_reader :id, :name, :description, :unit_price, :created_at, :updated_at, :merchant_id, :sales_engine

	def initialize(data_hash, item_repo)
		@id          = data_hash[:id].to_i
		@name        = data_hash[:name]
		@description = data_hash[:description]
		@unit_price  = data_hash[:unit_price]
		@created_at  = data_hash[:created_at]
		@updated_at  = data_hash[:updated_at]
		@merchant_id = data_hash[:merchant_id].to_i
		@item_repo = item_repo
	end

	def unit_price_to_dollars
		unit_price.to_f
	end

end