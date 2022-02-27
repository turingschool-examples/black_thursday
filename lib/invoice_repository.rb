require_relative 'invoice'
class InvoiceRepository

  def inspect
    "#<\#{self.class} \#{@invoices.size} rows>"
  end

  def initialize(data)
    @invoices = []
      CSV.foreach(data, headers: true, header_converters: :symbol) do |row| header ||= row.headers
        @invoices << Invoice.new(row)
    end
  end


  def all
    @invoices
  end

  def find_by_id(invoice_id)
    @invoices.find { |invoice| invoice.id == invoice_id}
  end

  def find_all_by_customer_id(customer_id)
    @invoices.find_all { |invoice| invoice.customer_id == customer_id}
  end

  def find_all_by_merchant_id(merchant_id)
    @invoices.find_all { |invoice| invoice.merchant_id == merchant_id}
  end

  def find_all_by_status(status)
    @invoices.find_all { |invoice| invoice.status == status}
  end

end
