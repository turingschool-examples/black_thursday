require'csv'
require_relative'item'

class ItemRepository
	attr_reader :items, :all, :sales_engine

	def initialize(item, sales_engine)
		@items = CSV.open item, headers: true, header_converters: :symbol
		@sales_engine = sales_engine
		@all = Array.new
		parse_csv
	end

	def parse_csv
		items.each do |item|
			all << Item.new(item, self)
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

	def find_all_with_description(phrase)
		all.select do |instance|
			if instance.description.downcase.include?(phrase.downcase)
				instance
			end
		end
	end

	def find_all_by_price(price)
		all.select do |instance|
			if instance.unit_price.to_s.include?(price.to_s)
				instance
			end
		end
	end

	def find_all_by_price_in_range(range)
		all.select do |instance|
			if range.include?(instance.unit_price)
				instance
			end
		end
	end

	def find_all_by_merchant_id(id)
		all.select do |instance|
			if instance.merchant_id.to_s.include?(id.to_s)
				instance
			end
		end
	end

	def inspect
    "#<#{self.class} #{@items.size} rows>"
	end
end