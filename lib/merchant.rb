class Merchant
	attr_reader :id, :name, :created_at, :updated_at

	def initialize(data_hash, sales_engine)
		@id = data_hash[:id]
		@name = data_hash[:name]
		@created_at = data_hash[:created_at]
		@updated_at = data_hash[:updated_at]
		@sales_engine = sales_engine
	end

end