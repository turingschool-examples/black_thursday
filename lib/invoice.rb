class Invoice
	attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at, :ir

	def initialize(data_hash, invoice_repo)
		@id          = data_hash[:id].to_i
		@customer_id = data_hash[:customer_id].to_i
		@merchant_id = data_hash[:merchant_id].to_i
		@status      = data_hash[:status].to_sym
		@created_at  = Time.parse(data_hash[:created_at])
		@updated_at  = Time.parse(data_hash[:updated_at])
		@ir = invoice_repo
	end

	def merchant
		ir.sales_engine.merchants.find_by_id(merchant_id)
	end

	def items
		ir.sales_engine.invoice_items.find_all_by_invoice_id(id).map { |invoice_item| invoice_item.find_items_by_ids }
	end

	def transactions
		ir.sales_engine.transactions.find_all_by_invoice_id(id)
	end

	def customer
		ir.sales_engine.customers.find_by_id(customer_id)
	end

	def is_paid_in_full?
		all = ir.sales_engine.transactions.find_all_by_invoice_id(id)
		all.all? {|trans| trans.result == "success"} && !all.empty?
	end

	def total
		inv_items_arr = ir.sales_engine.invoice_items.find_all_by_invoice_id(id)
		inv_items_arr.map { |ii| ii.quantity * ii.unit_price }.reduce(:+)
	end
end