require'bigdecimal'
require'bigdecimal/util'

class Item
	attr_reader :id, :name, :description, :unit_price, :created_at, :updated_at, :merchant_id, :item_repo

	def initialize(data_hash, item_repo)
		@id          = data_hash[:id].to_i
		@name        = data_hash[:name]
		@description = data_hash[:description]
		@unit_price  = ((data_hash[:unit_price].to_i).to_d) / 100
		@created_at  = Time.parse(data_hash[:created_at])
		@updated_at  = Time.parse(data_hash[:updated_at])
		@merchant_id = data_hash[:merchant_id].to_i
		@item_repo = item_repo
	end

	def unit_price_to_dollars
		unit_price.to_f
	end

	def merchant
		item_repo.sales_engine.merchants.find_by_id(merchant_id)
	end
end