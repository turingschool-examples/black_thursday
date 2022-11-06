require_relative 'reposable'
require_relative './invoice_item'

class InvoiceItemRepository
  include Reposable

  attr_accessor :all

  def initialize(all = [])
    @all = all
  end

  def find_all_by_item_id(item_id)
    all.find_all do |invoice_item|
      item_id.to_i == invoice_item.item_id.to_i
    end
  end

  def find_all_by_invoice_id(invoice_id)
    all.find_all do |invoice_item|
      invoice_id.to_i == invoice_item.invoice_id.to_i
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end