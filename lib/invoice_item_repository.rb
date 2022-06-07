require 'CSV'
require 'BigDecimal'
require_relative './invoice_item.rb'

class InvoiceItemRepository
  attr_reader :all
  def initialize(invoice_item_path)
    @invoice_item_path = invoice_item_path
    @all = []
  end



end
