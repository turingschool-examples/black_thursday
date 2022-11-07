require_relative '../lib/modules/repo_queries'
require 'bigdecimal'

class InvoiceItemRepository
  include RepoQueries

  attr_reader :data, :engine

  def initialize(file = nil, engine = nil)
    @data = []
    @engine = engine
    @child = InvoiceItem
    load_data(file)
  end

  def find_all_by_item_id(item_id)
    all.find_all do |datum|
      datum.item_id == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    all.find_all do |datum|
      datum.invoice_id == invoice_id
    end
  end

  def update(id, attributes)
    return if attributes.empty?
    updated = find_by_id(id)
    updated.quantity = attributes[:quantity]
    updated.unit_price = attributes[:unit_price]
    updated.updated_at = Time.now
  end
end
