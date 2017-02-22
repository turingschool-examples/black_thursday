require'csv'
require_relative'merchant'

class MerchantRepository
	attr_reader :merchant, :all

	def initialize(merchant, sales_engine)
		@merchant = CSV.open merchant, headers: true, header_converters: :symbol
		@sales_engine = sales_engine
	end

	def all
		merchant.map do |m|
			Merchant.new(m, self)
		end
	end

	def find_by_name(name)
		merchant.find do |row|
			if row[:name].downcase == name.downcase
				Merchant.new(name, self)
			end
		end
	end

	def find_all_by_name(name)
		merchant.select do |row|
			if row[:name].downcase == name.downcase
				merchant
			end
		end
	end

end