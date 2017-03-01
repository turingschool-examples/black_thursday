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
		merchant.each { |merchants| all << Merchant.new(merchants, self) }
	end

	def find_by_name(name)
		all.find { |instance| instance if instance.name.downcase == name.downcase }
	end

	def find_by_id(id)
		all.find { |instance| instance if instance.id == id.to_i }
	end

	def find_all_by_name(name)
		all.select {
			|instance| instance.name if instance.name.downcase.include?(name.downcase)
		}
	end
end