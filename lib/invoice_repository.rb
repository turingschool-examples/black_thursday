require'csv'
require_relative'invoice'

class InvoiceRepository
	attr_reader :sales_engine, :invoice, :all

	def initialize(invoice_path, sales_engine)
		@invoice = CSV.open invoice_path, headers: true, header_converters: :symbol
		@sales_engine = sales_engine
		@all = Array.new
		parse_csv
	end

	def parse_csv
		invoice.each do |invoices|
			all << Invoice.new(invoices, self)
		end
	end

	def find_by_id(id)
		all.find do |instance|
			if instance.id == id.to_i
				instance
			end
		end
	end

	def find_all_by_customer_id(id)
		all.select do |instance|
			if instance.customer_id == id
				instance
			end
		end
	end

	def find_all_by_merchant_id(id)
		all.select do |instance|
			if instance.merchant_id == id
				instance
			end
		end
	end

	def find_all_by_status(status)
		all.select do |instance|
			if instance.status == status.to_sym
				instance
			end
		end
	end

	def inspect
    "#<#{self.class} #{@invoices.size} rows>"
	end

end