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

  def merchant
    ir_instance.sales_engine_instance.merchants.find_by_id(merchant_id)
  end
end
