# frozen_string_literal: true

require_relative 'base_repository'
require_relative 'invoice'

# invoice repo
class InvoiceRepository < BaseRepository
  def invoices
    @models
  end

  def populate
    @models ||= csv_table_data.map { |attribute_hash| Invoice.new(attribute_hash, self) }
  end
end
