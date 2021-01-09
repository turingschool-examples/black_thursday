require_relative 'invoice.rb'

class InvoiceRepository
  attr_reader :invoices

  def initialize(file_path, engine)
    @invoices = create_repository(file_path)
    @engine = engine
  end

  def create_repository(file_path)
    file = CSV.readlines(file_path, headers: true, header_converters: :symbol)
    file.map do |row|
      Invoice.new(row)
    end
  end

  def inspect
    "#<#{self.class} #{invoices.size} rows>"
  end

  def all
    @invoices
  end

  def find_by_id(id)
    @invoices.find do |invoice|
      invoice.id.to_i == id
    end
  end

  def find_all_by_customer_id(customer_id)
    @invoices.find_all do |invoice|
      invoice.customer_id.to_i == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @invoices.find_all do |invoice|
      invoice.merchant_id.to_i == merchant_id
    end
  end

  def find_all_by_status(status)
    @invoices.find_all do |invoice|
      invoice.status == status
    end
  end

  def max_invoice_id
    @invoices.max_by do |invoice|
      invoice.id
    end.id
  end

  def create(attributes)
    @invoices.push(Invoice.new({
                                  id: max_invoice_id + 1,
                                  customer_id: attributes[:customer_id],
                                  merchant_id: attributes[:merchant_id],
                                  status: attributes[:status],
                                  created_at: Time.now.to_s,
                                  updated_at: Time.now.to_s
                                  }))
  end

  def update(id, attributes)
    invoice = find_by_id(id)
    return nil if invoice.nil?
    invoice.status = attributes[:status]
    invoice.updated_at = Time.now
  end

  def delete(id)
    @invoices.delete(find_by_id(id))
  end

end
