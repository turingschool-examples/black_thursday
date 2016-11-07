require_relative './invoice'

class InvoiceRepo
  include DataParser
  attr_reader :all

  def initialize(file, parent = nil)
    @all    = parse_data(file).map { |row| Invoice.new(row, self) }
    @parent = parent
  end

  def find_by_id(id)
    @all.find { |invoice| invoice.id.eql?(id) }
  end

  def find_all_by_customer_id(id)
    @all.find_all { |invoice| invoice.customer_id.eql?(id) }
  end

  def find_all_by_merchant_id(id)
    @all.find_all { |invoice| invoice.merchant_id.eql?(id) }
  end

  def find_all_by_status(status)
    @all.find_all { |invoice| invoice.status.eql?(status) }
  end

  def find_merchant_by_merchant_id(id)
    @parent.find_merchant_by_merchant_id(id)
  end

  def find_transactions_by_invoice_id(id)
    @parent.find_transactions_by_invoice_id(id)
  end

  def find_customer_by_customer_id(id)
    @parent.find_customer_by_customer_id(id)
  end

  def find_invoice_items_by_invoice_id(id)
    @parent.find_invoice_items_by_invoice_id(id)
  end

  def find_item_by_item_id(id)
    @parent.find_item_by_item_id(id)
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end
end
