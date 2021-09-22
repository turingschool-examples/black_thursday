require 'csv'
require_relative 'invoice'

class InvoiceRepository
  attr_reader :all

  def initialize(file_path, engine)
    @engine = engine
    @all = create_repository(file_path)
  end

  def create_repository(file_path)
    all = []

    csv = CSV.read(file_path, headers: true, header_converters: :symbol)
     csv.map do |row|
       all << Invoice.new(row)
    end
    all
  end

  def find_by_id(id)
    @all.find_all do |invoice|
      invoice.id == id
    end.pop
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
    id_max = @all.max_by {|invoice| invoice.id}
    attributes[:id] = id_max.id + 1
    new = Invoice.new(attributes)
    @all.push(new)
  end

  def update(id, attributes)

    updated_invoice = self.find_by_id(id)
    updated_invoice.status = attributes[:status]
    updated_invoice.updated_at = attributes[:updated_at]
    updated_invoice
  end

  def delete(id)
    x = (self.all).find_index(self.find_by_id(id))
    self.all.delete_at(x)
    self.all
  end

  def inspect
    "#<#{self.class} #{@invoice.size} rows>"
  end
end
