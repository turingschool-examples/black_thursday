require 'bigdecimal'
require 'pry'
require 'time'
class Item
attr_reader :item_info, :ir_instance
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
		#format as BigDecimal
	end

	def description
		@item_info[:description]
	end

	def created_at
		@item_info[:created_at]
	end

	def updated_at
		@item_info[:updated_at]
	end

	def merchant_id
		@item_info[:merchant_id]
	end

	 def unit_price_to_dollars
    unit_price.to_f / 100
   end
end
