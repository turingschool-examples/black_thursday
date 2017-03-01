class Merchant
	attr_reader :id, :name, :created_at, :updated_at, :mr

	def initialize(data_hash, merchant_repo)
		@id 				   = data_hash[:id].to_i
		@name          = data_hash[:name]
		@created_at    = data_hash[:created_at]
		@updated_at    = data_hash[:updated_at]
		@mr            = merchant_repo
	end

	def items
		mr.sales_engine.items.find_all_by_merchant_id(id)
	end

	def invoices
		mr.sales_engine.invoices.find_all_by_merchant_id(id)
	end

	def customers
		mr.sales_engine.invoices.find_all_by_merchant_id(id).map {
			|invoices| invoices.customer
		}.uniq
	end
end