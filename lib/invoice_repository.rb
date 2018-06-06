require_relative 'invoice'

class InvoiceRepository
  attr_reader :all

  def initialize
    @all = []
  end

  def load_invoices(csv)
    csv.each do |invoice|
      invoice[:created_at] = Time.parse(invoice[:created_at])
      invoice[:updated_at] = Time.parse(invoice[:updated_at])
      @all << Invoice.new(invoice)
    end
  end

  def find_by_id(invoice_id)
    @all.find do |invoice|
      invoice.id.to_i == invoice_id
    end
  end

  def find_all_by_customer_id(id)
    @all.find_all do |invoice|
      invoice.customer_id.to_i == id
    end
  end

  def find_all_by_merchant_id(id)
    @all.find_all do |invoice|
      invoice.merchant_id.to_i == id
    end
  end

  def find_all_by_status(status)
    @all.find_all do |invoice|
      invoice.status == status
    end
  end

  def create(invoice)
    new_id = @all.max_by do |invoice|
      invoice.id.to_i
    end.id.to_i + 1

    invoice[:id] = new_id

    @all << Invoice.new(invoice)
  end

  def update(id, attributes)
    invoice = find_by_id(id)
    if invoice
      invoice.update_status(attributes[:status])
    end
  end

  def delete(id)
    @all.delete_if do |invoice|
      invoice.id.to_i == id
    end
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end
end
