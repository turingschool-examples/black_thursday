require 'csv'
require_relative 'repository'
require_relative 'invoice'

class InvoiceRepository < Repository

  attr_reader :klass, :data

  def initialize(sales_engine, path)
    super(sales_engine, path, Invoice)
  end

  def all
    data
  end


  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end


  # def find_by_id

  # end
  #
  # def find
  #
  # end

end
