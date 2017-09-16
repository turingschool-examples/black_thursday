require_relative 'invoice'

class InvoiceRepository
  attr_accessor :all

  def initialize(file_path, parent=nil)
    @all    = csv_parse(file_path).map {|row| Invoice.new(row, self)}
    @parent = parent
  end

  def csv_parse(file_path)
    CSV.open file_path, headers: true, header_converters: :symbol
  end

  def find_by_id(id_number)
    all.find {|invoice| invoice.id.to_i == id_number.to_i}
  end

  def find_all_by_customer_id(customer_id)
    all.select {|invoice| invoice.customer_id == customer_id}
  end

  def find_all_by_merchant_id(merchant_id)
    all.select {|invoice| invoice.merchant_id == merchant_id}
  end

  def find_all_by_status(status)
    all.select {|invoice| invoice.status == status}
  end

  def find_merchant_from_invoice(merchant_id)
    @parent.find_merchant_from_invoice(merchant_id)
  end

  def find_items_by_invoice(id)
    @parent.find_items_by_invoice(id)
  end

  def find_transactions_by_invoice(id)
    @parent.find_transactions_by_invoice(id)
  end

  def find_customer_by_invoice(id)
    @parent.find_customer_by_invoice(id)
  end

  def inspect
    "#{self.class}"
  end
end
