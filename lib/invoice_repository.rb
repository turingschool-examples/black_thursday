require_relative 'invoice'
require_relative 'repository'

class InvoiceRepository
  include Repository
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

  def create(attributes)
    highest_id = @repository.max_by { |invoice| invoice.id }
    attributes[:id] = highest_id.id + 1
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = (Time.now).to_s
    @repository << Invoice.new(attributes)
  end

  def find_all_by_customer_id(id)
    @repository.find_all do |invoice|
      id == invoice.customer_id
    end
  end

  def find_all_by_status(status)
    @repository.find_all do |invoice|
      invoice.status == status
    end
  end
end
