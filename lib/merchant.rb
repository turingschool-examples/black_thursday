class Merchant
	attr_reader :id, :parent, :customer_id, :status, :merchant_id
	attr_accessor :name

	def initialize(data, parent)
		@data = data
		@id = data[:id]
		@name = data[:name]
		@parent = parent
		@merchant_id = data[:merchant_id].to_i
		@customer_id = data[:customer_id].to_i
	end

	# def merchant_id
	#   @data[:merchant_id].to_i
	# end

	def status
		@data[:status].to_sym
	end

	def created_at
		@data[:created_at]
	end

	def updated_at
		@data[:updated_at]
	end
	

end
