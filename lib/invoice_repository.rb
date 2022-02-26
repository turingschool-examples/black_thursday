require_relative '../lib/findable.rb'
require_relative '../lib/invoice.rb'
require 'pry'

class InvoiceRepository
  include Findable
  attr_reader :all
  def initialize(invoice_array)
    @all = invoice_array
  end
end
