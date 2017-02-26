class Merchant
	attr_reader :merchant_info, :mr_instance
	def initialize(merchant_info, mr_instance)
		@merchant_info = merchant_info
		@mr_instance = mr_instance
	end

	def name
		#call this instead of hash for refactor
		merchant_info[:name]
	end

	def id
		merchant_info[:id]
	end

	def items
		mr_instance.sales_engine_instance.items.find_all_by_merchant_id(id)
	end

	def invoices
		mr_instance.sales_engine_instance.invoices.find_all_by_merchant_id(id)
	end

	# def customers

	# end
end
