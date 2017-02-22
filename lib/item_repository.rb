require'csv'
require_relative'items'

class ItemRepository
	attr_reader :item

	def initialize(item, sales_engine)
		@item = CSV.open item, headers: true, header_converters: :symbol
		@sales_engine = sales_engine
	end

	def all
		item.map do |item|
			Items.new(item, self)
		end
	end

	def find_by_name(name)
		all.find do |instance|
			if instance.name.downcase == name.downcase
				instance
			end
			name
		end
	end

	def find_by_id(id)
		all.find do |instance|
			if instance.id == id
				instance
			end
			id
		end
	end

end