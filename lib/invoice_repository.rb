require_relative 'searching'
require_relative 'invoice'

# Repository for handling and storing invoices
class InvoiceRepository
  include Searching
  attr_reader :all

  def initialize(file_path, sales_eng)
    @all = from_csv(file_path)
    @sales_eng = sales_eng
  end

  def add_elements(data)
    data.map { |row| Invoice.new(row, self) }
  end

  def find_all_by_customer_id(id)
    @all.find_all { |obj| obj.customer_id == id }
  end

  def find_all_by_status(status)
    @all.find_all { |obj| obj.status == status.to_sym }
  end

  def merchant(id)
    @sales_eng.find_invoice_merchant(id)
  end

  def inspect
    "#<#{self.class} #{@all.length} rows>"
  end
end
