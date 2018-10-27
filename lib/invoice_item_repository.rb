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

  

end
