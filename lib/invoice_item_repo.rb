require_relative './invoice_item'

class InvoiceItemRepo
  def initialize(sales_engine = nil)
    @invoice_items = []
    @sales_engine = sales_engine
  end

  def all
    @invoice_items
  end

  def add_invoice_item(invoice_item_details)
    @invoice_items << InvoiceItem.new(invoice_item_details)
  end

  def find_by_id(id)
    @invoice_items.find do |invoice_item|
      invoice_item.id == id
    end
  end

  def find_all_by_item_id(item_id)
    @invoice_items.find_all do |invoice_item|
      invoice_item.item_id == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @invoice_items.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end

end
