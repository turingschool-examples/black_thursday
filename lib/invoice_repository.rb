require_relative 'invoice'
require_relative 'repo_methods'

class InvoiceRepository
  include RepoMethods

  def initialize(invoice_data)
    @invoice_rows ||= build_invoice(invoice_data)
    @repo = @invoice_rows
  end

  def build_invoice(invoice_data)
    invoice_data.map do |invoice|
      Invoice.new(invoice)
    end
  end

  def all
    @repo
  end

  def find_by_id(id)
    @repo.find do |invoice|
      invoice.id == id
    end
  end

  def find_all_by_customer_id(customer_id)
    @repo.find_all do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @repo.find_all do |invoice|
      invoice.merchant_id == merchant_id
    end
  end

  def find_all_by_status(status)
    @repo.find_all do |invoice|
      invoice.status == status
    end
  end

  def create(attributes)
    id = create_id
    invoice = Invoice.new(
      id: id,
      customer_id: attributes[:customer_id],
      merchant_id: attributes[:merchant_id],
      status: attributes[:status],
      created_at: Time.now,
      updated_at: Time.now
      )
    @repo << invoice
    invoice
  end

  def create_id
    find_highest_id.id + 1
  end

  def find_highest_id
    @repo.max_by do |invoice|
      invoice.id
    end
  end

  def update(id, attributes)
    invoice = find_by_id(id)
    return if invoice.nil?
    invoice.status = attributes[:status]
    invoice.updated_at = Time.now
    invoice
  end

  def delete(id)
    invoice = @repo.find_index do |invoice|
      invoice.id == id
    end
    return if invoice.nil?
    @repo.delete_at(invoice)
  end

  def inspect
    "#<#{self.class} #{@repo.size} rows>"
  end
end
