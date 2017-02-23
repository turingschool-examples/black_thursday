require 'pry'
class Item
	def initialize(item_info, ir_instance)
		@item_info = item_info
		@ir_instance = ir_instance
	end

	def name
		@item_info[:name]
	end

	def id
		@item_info[:id]
	end

	def unit_price
		@item_info[:unit_price]
		# binding.pry
	end

	def description
		@item_info[:description]
	end
end
