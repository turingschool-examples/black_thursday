# frozen_string_literal: true

require './lib/general_repo'
require './lib/invoice_item'

# this is the InvoiceItemRepository class
class InvoiceItemRepository < GeneralRepo
  def initialize(data)
    super(data)
  end

  def create(data)
    data[:id] ||= 1 if repository == []
    data[:id] ||= (@repository.last.id.to_i + 1).to_s
    @repository << InvoiceItem.new(data)
  end

  def find_all_by_item_id(item_id)
    repository.find_all do |ii|
      ii.item_id == item_id
    end
  end
end
