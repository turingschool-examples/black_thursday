require './lib/item'
require 'csv'
require 'pry'
require 'bigdecimal'

class ItemRepository	
	attr_reader :file, :items
	def initialize(file, sales_engine_instance)
		@file = file
		@sales_engine_instance = sales_engine_instance
		@items = Hash.new(0)
		item_maker
	end

	def open_contents
		CSV.open(file, headers: true, header_converters: :symbol)
	end

	def item_maker
		open_contents.each do |row|
		@items[row[:id].to_i] = Item.new({:id => row[:id].to_i, :name => row[:name].upcase, :unit_price => row[:unit_price],
		:created_at => row[:created_at], :updated_at => row[:updated_at], :merchant_id => row[:merchant_id],
		:description => row[:description]}, self)
		# binding.pry
		end	
	end

	def all
		items.values
	end

	def find_by_id(id)
		items.has_key?(id) ? items[id] : nil
	end

	def find_by_name(name)
		found_item = all.find do |item|
			item.name == name.upcase
		end
		found_item
	end

	def find_all_with_description(fragment)
		found_descriptions = all.map do |item|
			if item.name.include?(fragment.upcase)
				item.name
				# binding.pry
			end
		end
		found_descriptions.compact			
	end

	def find_all_by_price(price)
		all.select do |item|
			price == item.unit_price
		# binding.pry
		end
	end

	#convert unit_price into big decimal and / 100
	#unit price method
end