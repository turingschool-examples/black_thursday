require_relative 'searching'
require_relative 'invoice'

class InvoiceRepository
	include Searching
	attr_reader :all

	def initialize(file_path)
		@file_path = file_path
		@all = add_invoices
	end

	def add_invoices
		data.map { |row| Invoice.new(row) }
	end

	def find_all_by_customer_id(id)
		@all.find_all do |obj|
			obj.customer_id.include?(id)
		end
	end
end
