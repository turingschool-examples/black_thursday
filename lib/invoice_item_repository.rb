require_relative 'invoice_item.rb'
require_relative 'repository_helper.rb'

class InvoiceItemRepository
  include RepositoryHelper
  attr_reader :repository

  def initialize(file_contents)
    @repository = file_contents.map { |invoice_item| InvoiceItem.new(invoice_item) }
  end

  def find_all_by_item_id(item_id)
    @repository.select { |invoice_item| invoice_item.item_id == item_id }
  end

end
