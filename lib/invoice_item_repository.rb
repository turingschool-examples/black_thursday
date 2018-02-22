require 'csv'
require_relative 'invoice_item'

class InvoiceItemRepository
  def initialize(filepath, parent)
    @invoice_items = []
    @parent = parent
    load_items(filepath)
  end

  def all
    @invoice_items
  end

  def load_items(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |row|
      @invoice_items << InvoiceItem.new(row, self)
    end
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

  # def invoice_repo_finds_merchant_via_engine(id)
  #   @parent.engine_finds_merchant_via_merchant_repo(id)
  # end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end
end
