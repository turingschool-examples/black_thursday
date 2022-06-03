require 'CSV'
require "BigDecimal"
require './lib/item.rb'

class ItemRepository
	attr_reader :all
	def initialize(items_path)
		@items_path = items_path
		@all = []

		CSV.foreach(@items_path, headers: true, header_converters: :symbol) do |row|
    @all << Item.new({
			:id => row[:id],
			:name => row[:name],
			:description => row[:description],
			:unit_price => row[:unit_price],
			:created_at => row[:created_at],
			:updated_at => row[:updated_at],
			:merchant_id => row[:merchant_id]})
		end
	end

	def find_by_id(id)
		@all.find do |item|
			item.id.to_i == id
		end
	end

	def find_by_name(name)
		@all.find do |item|
			item.name.downcase.include?(name.downcase)
		end
	end

	def find_all_with_description(description)
		@all.find_all do |item|
			item.description.downcase.include?(description.downcase)
		end
	end

	def find_all_by_price(unit_price)
		@all.find_all do |item|
			item.unit_price.include?(unit_price)
		end
	end

	def find_all_by_price_in_range(range)
		@all.find_all do |item|
			(range.min..range.max).include?(item.unit_price.to_i)
		end
	end

	def find_all_by_merchant_id(merchant_id)
		@all.find_all do |item|
			merchant_id.to_i == item.merchant_id.to_i
		end
	end
	#Ask instructor if only adding a name for a new item is okay...Ran out of time lol.

	def create(attributes)
		new_id = @all.last.id.to_i + 1
		new_attribute = attributes
		@all << Item.new(:id => new_id.to_s, :name => new_attribute[:name], :unit_price =>
		new_attribute[:unit_price], :description => new_attribute[:description], :created_at => Time.now)
		return @all.last
	end

	def update(id, attributes)
		updated_item = find_by_id(id)
		updated_item.name = attributes[:name]
		updated_item.unit_price = attributes[:unit_price]
		updated_item.description = attributes[:description]
		updated_item.updated_at = Time.now
	end

	def delete(id)
		removed_item = find_by_id(id)
    @all.delete(removed_item)
	end
end
