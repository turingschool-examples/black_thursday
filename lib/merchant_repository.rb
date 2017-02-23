require'csv'
require_relative'merchant'

class MerchantRepository
	attr_reader :merchant

	def initialize(merchant, sales_engine)
		@merchant = CSV.open merchant, headers: true, header_converters: :symbol
		@sales_engine = sales_engine
	end

	def all
		merchant.map do |merchants|
			Merchant.new(merchants, self)
		end
	end

	def find_by_name(name)
		all.find do |instance|
			if instance.name.downcase == name.downcase
				instance
			end
		end
	end

	def find_by_id(id)
		all.find do |instance|
			if instance.id.downcase == id.downcase
				instance
			end
		end
	end

	def find_all_by_name(name)
		all.select do |instance|
			if instance.name.downcase == name.downcase
				instance.name
			end
		end
	end

end