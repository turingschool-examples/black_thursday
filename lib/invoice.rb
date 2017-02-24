class Invoice
	attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at, :invoice_repo

	def initialize(data_hash, invoice_repo)
		@id          = data_hash[:id].to_i
		@customer_id = data_hash[:customer_id].to_i
		@merchant_id = data_hash[:merchant_id].to_i
		@status      = data_hash[:status].to_sym
		@created_at  = Time.parse(data_hash[:created_at])
		@updated_at  = Time.parse(data_hash[:updated_at])
		@invoice_repo = invoice_repo
	end

	def merchant
		invoice_repo.sales_engine.merchants.find_by_id(merchant_id)
	end
end