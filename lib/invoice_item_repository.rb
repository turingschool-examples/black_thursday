require 'pry'
require 'CSV'
require_relative './repository'

class InvoiceItemRepository < Repository

  def new_record(row)
    InvoiceItem.new(row)
  end

  def find_all_by_item_id(id)
    @repo_array.find_all do |item|
      item.id == id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @repo_array.find_all do |item|
      item.invoice_id == invoice_id
    end
  end

end
