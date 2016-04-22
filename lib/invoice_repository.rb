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
    invoice_repository.find_all do |invoice|
      invoice.status.downcase == status.downcase
    end
  end

  def find_merchant_by_invoice_merch_id(merchant_id)
    @se.find_merchant_by_merch_id(merchant_id)
  end


end
