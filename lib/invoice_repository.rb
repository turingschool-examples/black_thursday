require_relative 'invoice.rb'

class InvoiceRepository
  attr_reader :repository

  def initialize(file_contents)
    @repository = file_contents.map { |invoice| Invoice.new(invoice) }
  end

  def all
    @repository
  end

  def find_by_id(id)
    @repository.find { |invoice| invoice.id == id}
  end

  def find_all_by_customer_id(customer_id)
    @repository.select { |invoice| invoice.customer_id == customer_id }
  end

  def find_all_by_merchant_id(merchant_id)
    @repository.select { |invoice| invoice.merchant_id == merchant_id }
  end

  def find_all_by_status(status)
    @repository.select { |invoice| invoice.status == status }
  end

  def create(attributes)
    sorted = @repository.sort_by { |invoice| invoice.id }
    new_id = sorted.last.id + 1
    attributes[:id] = new_id
    new_invoice = Invoice.new(attributes)
    @repository << new_invoice
    new_invoice
  end

  def update(id, attributes)
    invoice = find_by_id(id)
    if !invoice.nil?
      invoice.status = attributes[:status]
      invoice.updated_at = Time.now
      invoice
    end
  end

  def delete(id)
    invoice = find_by_id(id)
    @repository.delete(invoice)
  end

  def inspect
    "#<#{self.class} #{@repository.size} rows>"
  end

end
