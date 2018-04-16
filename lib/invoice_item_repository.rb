# frozen_string_literal: true

require_relative 'base_repository'
require_relative 'invoice_item'

# invoice item repo
class InvoiceItemRepository < BaseRepository
  def invoice_items
    @models
  end

  def populate
    @models ||= csv_table_data.map { |attribute_hash| InvoiceItem.new(attribute_hash, self) }
  end
end
