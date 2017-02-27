require'csv'
require_relative'inspect'
require_relative'invoice'

class InvoiceRepository
	attr_reader :sales_engine, :invoice, :all
	include Inspect

	def initialize(invoice_path, sales_engine)
		@invoice = CSV.open invoice_path, headers: true, header_converters: :symbol
		@sales_engine = sales_engine
		@all = Array.new
		parse_csv
	end

	def parse_csv
		invoice.each { |invoices| all << Invoice.new(invoices, self) }
	end

	def find_by_id(id)
		all.find { |instance| instance if instance.id == id.to_i }
	end

	def find_all_by_customer_id(id)
		all.select { |instance| instance if instance.customer_id == id }
	end

	def find_all_by_merchant_id(id)
		all.select { |instance| instance if instance.merchant_id == id }
	end

	def find_all_by_status(status)
		all.select { |instance| instance if instance.status == status.to_sym }
	end

end