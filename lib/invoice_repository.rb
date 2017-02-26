# require 'invoice'
require_relative '../lib/data_access'

class InvoiceRepository
  include DataAccess

  attr_reader :csv_file, :all, :parent

  def initialize(path, parent=nil)
    @csv_file = CSV.open(path, headers: true, header_converters: :symbol)
    @all = []
    @parent = parent
    # make_invoices
  end


  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

end