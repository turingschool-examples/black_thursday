require_relative 'searching'
require_relative 'invoice'

# Repository for handling and storing invoices
class InvoiceRepository
  include Searching
  attr_reader :all

  def initialize(file_path, sales_engine)
    @file_path    = file_path
    @all          = add_invoices
    @sales_engine = sales_engine
  end

  def add_invoices
    data.map { |row| Invoice.new(row, self) }
  end

  def find_all_by_customer_id(id)
    @all.find_all do |obj|
      obj.customer_id == id
    end
  end

  def find_all_by_status(status)
    @all.find_all do |obj|
      obj.status == status
    end
  end

  def inspect
    self
  end
end
