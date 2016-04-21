require_relative 'invoice'

class InvoiceRepository
  attr_accessor :invoice_repository

  def initialize(parent = nil)
    @se = parent
    @invoice_repository = []
  end

  def inspect
  "#<#{self.class} #{@invoices.size} rows>"
  end

  def invoice(invoice_contents)
    invoice_contents.each do |column|
      @invoice_repository << Invoice.new(column, self)
    end
    self
  end

  def all
    invoice_repository.empty? ?  nil : invoice_repository
  end

  def find_by_id(find_id)
    invoice_repository.find {|invoice| invoice.id == find_id }
  end

  def find_all_by_customer_id(find_id)
    invoice_repository.find_all {|invoice| invoice.customer_id == find_id }
  end

  def find_all_by_merchant_id(find_id)
    invoice_repository.find_all {|invoice| invoice.merchant_id == find_id }
  end

  def find_all_by_status(status)
    invoice_repository.find_all {|invoice| invoice.status.downcase == status.downcase }
  end


end

# The data can be found in data/invoices.csv so the instance is created and used like this:
#
# se = SalesEngine.from_csv({:invoices => "./data/invoices.csv"})
# invoice = se.invoices.find_by_id(6)
# # => <invoice>
