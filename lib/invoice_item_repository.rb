require_relative 'invoice_item'
require_relative 'repository_assistant'

class InvoiceItemRepository
  include RepositoryAssistant

  def initialize(data_file)
    @repository = data_file.map {|item| InvoiceItem.new(item)}
  end

  def find_all_by_item_id(id)
    @repository.find_all do |invoice_item|
      invoice_item.item_id == id
    end
  end

  def find_all_by_invoice_id(id)
    @repository.find_all do |invoice_item|
      invoice_item.invoice_id == id
    end
  end

  def create(attributes)
    attributes[:id] = create_new_id_number
    @repository << InvoiceItem.new(attributes)
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end
end
