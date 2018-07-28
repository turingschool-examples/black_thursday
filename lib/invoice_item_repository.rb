require_relative 'invoice_item'
require_relative 'repo_methods'

class InvoiceItemRepository
  include RepoMethods

  def initialize(invoice_item_data)
    @invoice_rows ||= build_invoice(invoice_item_data)
    @repo = @invoice_rows
  end

  def build_invoice(invoice_item_data)
    invoice_item_data.map do |invoice_item|
      InvoiceItem.new(invoice_item)
    end
  end

  def find_all_by_item_id(item_id)
    @repo.find_all do |invoice_item|
      invoice_item.item_id == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @repo.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end
end
