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
end
