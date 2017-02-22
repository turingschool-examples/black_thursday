class Items

	def initialize(data_hash, sales_engine)
		@id          = data_hash[id]
		@name        = data_hash[name]
		@description = data_hash[description]
		@unit_price  = data_hash[unit_price]
		@created_at  = data_hash[created_at]
		@updated_at  = data_hash[updated_at]
		@merchant_id = data_hash[merchant_id]
		@sales_engine = sales_engine
	end

end