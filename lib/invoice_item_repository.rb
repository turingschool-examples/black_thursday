require 'csv'
require_relative './invoice_item'
require_relative 'repository'



class InvoiceItemRepository < Repository

  def new_obj(attributes)  
    new_obj_class(attributes, InvoiceItem)
  end

  def find_all_by_item_id(id)
    @repo.select { |invoice_item| invoice_item.item_id == id }
  end

  def find_all_by_invoice_id(id)
    @repo.select { |invoice_item| invoice_item.invoice_id == id }
  end
end
