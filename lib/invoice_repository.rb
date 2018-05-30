require_relative 'invoice'

class InvoiceRepository
  def initialize(loaded_file)
    @invoice_repo = loaded_file.map { |invoice| Invoice.new(invoice)}
  end

  def all
    @invoice_repo
  end

  def find_by_id(id)
    all.find {|invoice| invoice.id == id}
  end

  def find_all_by_customer_id(customer_id)
    all.find_all {|invoice| invoice.customer_id == customer_id}
  end

  def find_all_by_merchant_id(merchant_id)
    all.find_all {|invoice| invoice.merchant_id == merchant_id}
  end

  def find_all_by_status(status)
    all.find_all {|invoice| invoice.status == status}
  end

  def inspect
   "#{self.class} #{@invoice_repo.size} rows"
  end
end
