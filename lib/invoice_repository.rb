require_relative 'invoice'

class InvoiceRepository
  # Responsible for holding and searching Invoice instances.
  attr_reader :invoices

  def initialize(invoices)
    @invoices = invoices
    @repository = []
    create_all_invoices
  end

  def create_all_invoices
    @invoices.each do |invoice|
      @repository << Invoice.new(invoice)
    end
  end

  def all
    @repository
  end

  def find_by_id(id)
    @repository.find do |invoice|
      id == invoice.id
    end
  end

  def find_all_by_customer_id(id)
    @repository.find_all do |invoice|
      id == invoice.customer_id
    end
  end

  def find_all_by_merchant_id(id)
    @repository.find_all do |invoice|
      id == invoice.merchant_id
    end
  end

  def find_all_by_status(status)
    @repository.find_all do |invoice|
      invoice.status == status
    end
  end

  def delete(id)
    invoice = find_by_id(id)
    @repository.delete(invoice)
  end

  def create(attributes)
    highest_id = @repository.max_by do |invoice|
      invoice.id
    end
    attributes[:id] = highest_id.id + 1
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = (Time.now).to_s
    @repository << Invoice.new(attributes)
  end

  def update(id, attributes)
    invoice = find_by_id(id)
    unless invoice.nil?
      invoice.status = attributes[:status] if attributes[:status]
      invoice.updated_at = Time.now
    end
    return nil
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end
end
