require'csv'
require_relative'merchant'

class MerchantRepository
	attr_reader :merchant, :all

	def initialize(merchant, sales_engine)
		@merchant = CSV.open merchant, headers: true, header_converters: :symbol
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

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end