require_relative 'inspectable'

class InvoiceRepository
  include Inspectable

  attr_reader :sales_engine, :all, :file_path

  def initialize(file_path, sales_engine)
    @file_path = file_path
    @sales_engine = sales_engine
    @all = generate
  end

  def generate
    info = CSV.open(@file_path.to_s, headers: true, header_converters: :symbol)
    info.map do |row|
      Invoice.new(row, self)
    end
  end

  def find_by_id(id)
    @all.find do |invoice|
      invoice.id == id
    end
  end

  def find_all_by_customer_id(customer_id)
    @all.find_all do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all do |invoice|
      invoice.merchant_id == merchant_id
    end
  end

  def find_all_by_status(status)
    @all.find_all do |invoice|
      invoice.status == status
    end
  end

  def create(attributes)
    attributes[:id] = @all.last.id + 1
    @all << Invoice.new(attributes, self)
  end

  def update(id, attributes)
    invoice = find_by_id(id)
    return nil if invoice.nil?

    invoice.update_invoice(attributes)
  end

  def delete(id)
    deleted_invoice = find_by_id(id)
    @all.delete(deleted_invoice)
  end
end
