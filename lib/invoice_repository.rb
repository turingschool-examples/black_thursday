require_relative 'searching'
# require_relative 'invoice'

class InvoiceRepository
	include Searching
	attr_reader :all

	def initialize(file_name) 
		@file_name = file_name 
	end


end