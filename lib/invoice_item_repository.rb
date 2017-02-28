require'csv'
require_relative'invoice_item'
require_relative'inspect'

class InvoiceItemRepository
	attr_reader :sales_engine, :invoice_items, :all
	include Inspect

	def initialize(csv_path, sales_engine)
		@invoice_items = CSV.open csv_path, headers: true, header_converters: :symbol
		@sales_engine = sales_engine
		@all = Array.new
		parse_csv
	end

	def parse_csv
		invoice_items.each { |invoices| all << InvoiceItem.new(invoices, self) }
	end
	
	def find_by_id(id)
		all.find { |instance| instance if instance.id == id }
	end

	def find_all_by_item_id(item_id)
		all.select { |instance| instance if instance.item_id == item_id }
	end

	def find_all_by_invoice_id(invoice_id)
		all.select { |instance| instance if instance.invoice_id == invoice_id }
	end


end