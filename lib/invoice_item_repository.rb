require_relative 'invoice_item'
require 'csv'
require 'pry'
class InvoiceItemRepository
	attr_reader :file, :invoice_items, :sales_engine_instance
	def initialize(file, sales_engine_instance)
		@file = file
		@sales_engine_instance = sales_engine_instance
		@invoice_items = Hash.new(0)
		invoice_item_maker
	end

	def open_contents
		CSV.open(file, headers: true, header_converters: :symbol)
	end

	def invoice_item_maker
		open_contents.each do |row|
			id = row[:id].to_i
      #add bigdecimal/Time for price/created_at/updated_at
			invoice_items[id] = InvoiceItem.new({:id => id, :item_id => row[:item_id].to_i, :invoice_id => row[:invoice_id].to_i, :quantity => row[:quantity].to_i, :unit_price => row[:unit_price], :created_at => row[:created_at], :updated_at => row[:updated_at]}, self)
		end
	end

	def all
		invoice_items.values
	end

	def find_by_id(id)
		invoice_items.has_key?(id) ? invoice_items[id] : nil
	end

  def find_all_by_item_id(item_id)
    invoice_items.all.select do |invoice_item|
      invoice_item.item_id == item_id.to_i
    end
  end

  def find_all_by_invoice_id

  end


	# def find_all_by_name(fragment)
	# 	found_invoice_items = @invoice_items.values.map do |invoice_item|
	# 		if invoice_item.name.downcase.include?(fragment.downcase)
	# 			invoice_item
	# 		end
	# 	end
	# 	found_invoice_items.compact
	# end

	def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end
end
