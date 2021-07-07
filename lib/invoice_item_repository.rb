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

  def create(attributes)
    sorted = @repository.sort_by(&:id) # { |invoice_item| invoice_item.id }
    new_id = sorted.last.id + 1
    attributes[:id] = new_id
    new_invoice_item = InvoiceItem.new(attributes)
    @repository << new_invoice_item
    new_invoice_item
  end

  def update(id, attributes)
    invoice_item = find_by_id(id)
    return if invoice_item.nil?
    attributes.each do |key, value|
      invoice_item.quantity = value if key == :quantity
      invoice_item.unit_price = value if key == :unit_price
      invoice_item.updated_at = Time.now + 1
    end
  end

  def inspect
    "#<#{self.class} #{@repository.size} rows>"
  end
end
