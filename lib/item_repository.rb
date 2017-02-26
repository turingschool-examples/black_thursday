require_relative 'item'
require 'csv'
require 'pry'
require 'bigdecimal'
require 'time'

class ItemRepository
	attr_reader :file, :items, :sales_engine_instance
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
		@items[row[:id].to_i] = Item.new({:id => row[:id].to_i, :name => row[:name], :unit_price => BigDecimal.new(row[:unit_price].to_i)/100,
		:created_at => Time.parse(row[:created_at]), :updated_at => Time.parse(row[:updated_at]), :merchant_id => row[:merchant_id].to_i,
		:description => row[:description]}, self)
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
			item.name.downcase == name.downcase
		end
		found_item
	end

	def find_all_with_description(fragment)
		found_descriptions = all.map do |item|
			if item.description.downcase.include?(fragment.downcase)
				item

			end
		end
		found_descriptions.compact
	end

	def find_all_by_price(price)
		all.find_all do |item|
			item.unit_price == price
		end
	end

	def find_all_by_price_in_range(range)
    all.find_all do |instance|
       range.include?(instance.unit_price)
    end
  end

  def find_all_by_merchant_id(id)
    merchant = all.find_all do |item|
      item.merchant_id == id
    end
    merchant 
  end

	def inspect
    "#<#{self.class} #{@merchants.size} rows>"
    #possibly need to change @merchants to @items, check harness
  end
end
