# frozen_string_literal: true

require_relative './invoice_item'
require_relative './repository_helper'

# InvoiceItemRepository class
class InvoiceItemRepository
  include RepositoryHelper

  def update(id, params)
    return nil unless @repository.key?(id)
    sig_fig = params[:unit_price].to_s.size - 1

    invoice_item = find_by_id(id)
    invoice_item.quantity = params[:quantity] unless params[:quantity].nil?
    invoice_item.unit_price = BigDecimal(params[:unit_price], sig_fig) unless params[:unit_price].nil?
    invoice_item.updated_at = Time.now
  end

  def find_all_by_item_id(id)
    all.find_all do |invoice_item|
      invoice_item.item_id == id
    end
  end

  private

  def sub_class
    InvoiceItem
  end
end
