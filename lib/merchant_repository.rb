require'csv'

class MerchantRepository
	attr_reader :merchant

	def initialize(merchant, sales_engine)
		@merchant = CSV.open merchant, headers: true, header_converters: :symbol
		@sales_engine = sales_engine
		binding.pry
	end

	def find_by_name(name)
		id = nil
		merchant.each do |row|
			if row[:name] == name
				id = row[:id]
			end
		end
		id.to_i
	end

end