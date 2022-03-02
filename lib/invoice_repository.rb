require_relative 'invoice'
require_relative 'repository'

class InvoiceRepository < Repository

#  def inspect
#    "#<\#{self.class} \#{@invoices.size} rows>"
#  end

  def initialize(data)
    @invoices = []
      CSV.foreach(data, headers: true, header_converters: :symbol) do |row| header ||= row.headers
        @invoices << Invoice.new(row)
    end
    super(@invoices)
  end


#  def all
#    @invoices
#  end

  def find_by_id(invoice_id)
    @invoices.find { |invoice| invoice.id == invoice_id}
  end

  def find_all_by_customer_id(customer_id)
    @invoices.find_all { |invoice| invoice.customer_id == customer_id}
  end

#  def find_all_by_merchant_id(merchant_id)
 #   @invoices.find_all { |invoice| invoice.merchant_id == merchant_id}
 # end

  def find_all_by_status(status)
    @invoices.find_all { |invoice| invoice.status == status}
  end

  def create(attributes)
    attributes[:id] = @invoices.last.id + 1
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    new_invoice = Invoice.new(attributes)
    @invoices << new_invoice
    new_invoice
  end

  def update(id, attributes)
    invoice_to_update = find_by_id(id)
    if invoice_to_update != nil
        attributes.each do |key, value|
          if ![:id, :created_at, :merchant_id, :customer_id].include?(key)
            invoice_to_update.info[key.to_sym] = value
            invoice_to_update.info[:updated_at] = (Time.now + 1).to_s
          end
        end
    end
    invoice_to_update
  end

#  def delete(id)
#    @invoices.delete(find_by_id(id)) if find_by_id(id) != nil
#  end

end
