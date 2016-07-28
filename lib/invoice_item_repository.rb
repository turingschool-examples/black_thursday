require_relative '../lib/invoice_item'
class InvoiceItemRepository
  attr_reader :list_of_invoice_items,
              :parent_engine


  def initialize(invoice_items_data, parent_engine)
    @parent_engine = parent_engine
    @list_of_invoice_items = populate_invoice_items(invoice_items_data)
  end

  def populate_invoice_items(invoice_items_data)
    invoice_items_data.map do |datum|
      InvoiceItem.new(datum, self)
    end
  end

  def all
    list_of_invoice_items
  end

  def find_by_id(id_to_find)
    @list_of_invoice_items.find do |invoice_item|
      invoice_item.id == id_to_find
    end
  end

  def find_all_by_item_id(item_id_to_find)
    @list_of_invoice_items.find_all do |invoice_item|
      invoice_item.item_id == item_id_to_find
    end
  end

  def find_all_by_invoice_id(invoice_id_to_find)
    @list_of_invoice_items.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id_to_find
    end
  end


end
