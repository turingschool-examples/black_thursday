# frozen_string_literal: true

require_relative './invoice_item'
require_relative './repository_helper'

# InvoiceItemRepository class
class InvoiceItemRepository
  include RepositoryHelper

  def initialize
    @repository = {}
  end

  def create(params)
    params[:id] = @repository.max[0] + 1 if params[:id].nil?

    InvoiceItem.new(params).tap do |invoice_item|
      @repository[params[:id].to_i] = invoice_item
    end
  end

  def update(id, params)
    return nil unless @repository.key?(id)
    sig_fig = params[:unit_price].to_s.size - 1

    invoice_item = find_by_id(id)
    invoice_item.quantity = params[:quantity] unless params[:quantity].nil?
    invoice_item.unit_price = BigDecimal(params[:unit_price], sig_fig) unless params[:unit_price].nil?
    invoice_item.updated_at = Time.now
  end

  def all
    invoice_item_pairs = @repository.to_a.flatten
    remove_keys(invoice_item_pairs, InvoiceItem)
  end

  def find_all_by_item_id(id)
    all.find_all do |invoice_item|
      invoice_item.item_id == id
    end
  end

  def find_all_by_invoice_id(id)
    all.find_all do |invoice_item|
      invoice_item.invoice_id == id
    end
  end
end
