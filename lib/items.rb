class Items
	attr_reader :id, :name, :description, :unit_price, :created_at, :updated_at, :merchant_id, :sales_engine

	def initialize(data_hash, item_repo)
		@id          = data_hash[:id]
		@name        = data_hash[:name]
		@description = data_hash[:description]
		@unit_price  = data_hash[:unit_price]
		@created_at  = data_hash[:created_at]
		@updated_at  = data_hash[:updated_at]
		@merchant_id = data_hash[:merchant_id]
		@item_repo = item_repo
	end

end