require 'csv'
require_relative './invoice_item'
require_relative 'repository'


class InvoiceItemRepository < Repository
  attr_reader :repo

  def initialize
    @repo = []
  end

  def create(attributes)
    attributes[:id] ||= new_id(attributes)
    new_item = InvoiceItem.new(attributes)
    @repo << new_item
    new_item
  end

  def all
    @repo
  end

  def find_all_by_item_id(id)
    @repo.select { |invoice_item| invoice_item.item_id == id }
  end

  def find_all_by_invoice_id(id)
    @repo.select { |invoice_item| invoice_item.invoice_id == id }
  end

  def update(id, attributes)
    find_by_id(id).update(attributes) if find_by_id(id)
  end

  def inspect
    "#<#{self.class} #{@repo.size} rows>"
  end
end
