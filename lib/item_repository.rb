require'csv'
require_relative'item'
require_relative'inspect'

class ItemRepository
	include Inspect
	attr_reader :items, :all, :sales_engine

	def initialize(item, sales_engine)
		@items = CSV.open item, headers: true, header_converters: :symbol
		@sales_engine = sales_engine
		@all = Array.new
		parse_csv
	end

	def parse_csv
		items.each { |item| all << Item.new(item, self) } 
	end

	def find_by_name(name)
		all.find { |instance| instance if instance.name.downcase == name.downcase }
	end

	def find_by_id(id)
		all.find { |instance| instance if instance.id == id.to_i }
	end

	def find_all_with_description(phrase)
		all.select { |instance| instance if instance.description.downcase.include?(phrase.downcase) }
	end

	def find_all_by_price(price)
		all.select { |instance| instance if instance.unit_price.to_s.include?(price.to_s) }
	end

	def find_all_by_price_in_range(range)
		all.select { |instance| instance if range.include?(instance.unit_price) }
	end

	def find_all_by_merchant_id(id)
		all.select { |instance| instance if instance.merchant_id.to_s.include?(id.to_s) }
	end

end