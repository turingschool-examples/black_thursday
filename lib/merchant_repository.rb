require'csv'
require_relative'merchant'

class MerchantRepository
	attr_reader :merchant, :all

	def initialize(merchant, sales_engine)
		@merchant = CSV.open merchant, headers: true, header_converters: :symbol
		@sales_engine = sales_engine
		@all = Array.new
	end

	def add_merchant(data)
		all << Merchant.new(data)
	end

	def find_by_name(name)
		merchant.find do |merchant|
			if merchant[:name].downcase == name.downcase
				merchant[:id]
			end
		end
	end


end