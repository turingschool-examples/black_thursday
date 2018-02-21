require_relative 'searching'
require_relative 'invoice'

class InvoiceRepository
	include Searching
	attr_reader :all

	def initialize(file_name)
		@file_name = file_name
		@all = add_invoices
	end

	def add_invoices
		# require 'pry'; binding.pry
		data.map { |row| Invoice.new(row) }
	end


end
