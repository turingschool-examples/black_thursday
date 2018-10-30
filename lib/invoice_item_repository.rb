require_relative './invoice_item'
require_relative './repo_module'
class InvoiceItemRepository
  include RepoModule
  attr_reader :all

  def initialize(file_path)
    @class_name = InvoiceItem
    @all = from_csv(file_path)
  end

  def find_all_by_item_id(item_id)
    @all.find_all {|invoice_item| item_id == invoice_item.item_id}
  end

  def find_all_by_invoice_id(invoice_id)
    @all.find_all {|invoice_item| invoice_id == invoice_item.invoice_id}
  end
end
