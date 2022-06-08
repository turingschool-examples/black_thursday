require 'csv'
require_relative 'invoice_item'
require "bigdecimal"
require_relative 'inspector'

class InvoiceItemRepository
  include Inspector
  attr_reader :all

  def initialize(file_path)
    @file_path = file_path
    @all = []

    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << InvoiceItem.new(row)
    end
  end

  def find_all_by_item_id(item_id_search)
    @all.find_all do |invoice_item|
      invoice_item.item_id == item_id_search
    end
  end

  def find_all_by_invoice_id(invoice_id_search)
    @all.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id_search
    end
  end

  def update(invoice_item_id_search, attributes)
    @all.find do |invoice_item|
      if invoice_item.id == invoice_item_id_search
        invoice_item.quantity = attributes[:quantity] unless attributes[:quantity].nil?
        invoice_item.unit_price = attributes[:unit_price] unless attributes[:unit_price].nil?
        invoice_item.updated_at = Time.now
      end
    end
  end
end
