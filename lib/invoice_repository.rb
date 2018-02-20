require_relative 'searching'
# require_relative 'invoice'

class InvoiceRepository
  include Searching
	attr_reader :all


end