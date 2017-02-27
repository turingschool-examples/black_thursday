require'csv'
require_relative'merchant'
require_relative'inspect'

class MerchantRepository
	include Inspect
	attr_reader :merchant, :all, :sales_engine

	def initialize(merchant_path, sales_engine)
		@merchant = CSV.open merchant_path, headers: true, header_converters: :symbol
		@sales_engine = sales_engine
		@all = Array.new
		parse_csv
	end

	def parse_csv
		merchant.each do |merchants|
			all << Merchant.new(merchants, self)
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
			if instance.id == id.to_i
				instance
			end
		end
	end

	def find_all_by_name(name)
		all.select do |instance|
			if instance.name.downcase.include?(name.downcase)
				instance.name
			end
		end
	end

end