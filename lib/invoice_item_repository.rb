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
      @all << InvoiceItem.new({
        :id => row[:id].to_i,
        :item_id => row[:item_id].to_i,
        :invoice_id => row[:invoice_id].to_i,
        :quantity => row[:quantity],
        :unit_price => row[:unit_price],
        :created_at => row[:created_at],
        :updated_at => row[:updated_at]
        })
    end
  end

  def find_by_id(id_search)
    @all.find do |invoice_item|
      invoice_item.id == id_search
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

  def update(invoice_item_id_search, new_quantity, new_price)
    @all.find do |invoice_item|
      if invoice_item.id == invoice_item_id_search
        invoice_item.quantity = new_quantity
        invoice_item.unit_price = new_price
        invoice_item.updated_at = Time.now
      end
    end
  end

  def delete(invoice_item_id_search)
    @all.find do |invoice_item|
      if invoice_item.id == invoice_item_id_search
        @all.delete(invoice_item)
      end
    end
  end
end
