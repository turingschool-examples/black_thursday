require_relative 'sales_engine'
require_relative 'invoice'

class InvoiceRepository
  attr_reader :invoices

  def initialize(path, engine)
    @invoices = []
    @engine = engine
    make_invoices(path)
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

  def make_invoices(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      @invoices << Invoice.new(row, self)
    end
  end

  def all
    @invoices
  end

  def find_by_id(id)
    @invoices.find do |invoice|
      invoice.id == id
    end
  end

  def find_all_by_customer_id(customer_id)
    @invoices.find_all do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @invoices.find_all do |invoice|
      invoice.merchant_id == merchant_id
    end
  end  
  
  def find_all_by_status(status)
    @invoices.find_all do |invoice|
      invoice.status == status
    end
  end

  def generate_new_id
    highest_id_invoice = @invoices.max_by do |invoice|
      invoice.id
    end
    new_id = highest_id_invoice.id + 1
  end

  def create(attributes)
    attributes[:id] = generate_new_id
    @invoices << Invoice.new(attributes, self)
  end

#   def update(id, attributes)
#     item_to_update = find_by_id(id)
#     attributes.each do |iv, new_value|
#       item_to_update.send("#{iv}=", new_value)
#     end
#     item_to_update.format_unit_price
#     item_to_update.update
#   end

#   def delete(id)
#     items.delete(find_by_id(id))
#   end
end
