require'csv'

class ItemRepository
	attr_reader :item

	def initialize(item, sales_engine)
		@item = CSV.open item, headers: true, header_converters: :symbol
		@sales_engine = sales_engine
	end

end