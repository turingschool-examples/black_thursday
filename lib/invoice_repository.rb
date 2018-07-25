require_relative 'invoice'

class InvoiceRepository
  def initialize(invoice_data)
    @invoice_rows ||= build_invoice(invoice_data)
    @invoices = @invoice_rows
  end

  def build_invoice(invoice_data)
    invoice_data.map do |invoice|
      Invoice.new(invoice)
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
    @invoices << invoice
    invoice
  end

  def create_id
    find_highest_id.id + 1
  end

  def find_highest_id
    @invoices.max_by do |invoice|
      invoice.id
    end
  end

  # def update(id, attributes)
  #   invoice = find_by_id(id)
  #   return if invoice.nil?
  #   invoice.name = attributes[:name]
  #   invoice.updated_at = Time.now
  #   invoice
  # end
  #
  # def delete(id)
  #   invoice = @invoices.find_index do |invoice|
  #     invoice.id == id
  #   end
  #   return if invoice.nil?
  #   @invoices.delete_at(invoice)
  # end
  #
  # def inspect
  #   "#<#{self.class} #{@invoices.size} rows>"
  # end
end
