class Merchant
	attr_reader :id, :name, :created_at, :updated_at, :merchant_repo

	def initialize(data_hash, merchant_repo)
		@id 				   = data_hash[:id].to_i
		@name          = data_hash[:name]
		@created_at    = data_hash[:created_at]
		@updated_at    = data_hash[:updated_at]
		@merchant_repo = merchant_repo
	end

	def items
		merchant_repo.sales_engine.items.find_all_by_merchant_id(id)
	end

	def invoices
		merchant_repo.sales_engine.invoices.find_all_by_merchant_id(id)
	end

end