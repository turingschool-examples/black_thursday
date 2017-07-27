require 'pry'
require 'csv'
require 'time'
require_relative '../lib/invoice_item'
require_relative '../lib/file_opener'


class InvoiceItemRepository
  include FileOpener
  attr_reader :all

  def initialize(invoice_items, se)
    @invoice_items = open_csv(invoice_items)
    @se = se
    @all = @invoice_items.map do |row|
      InvoiceItem.new(row, self)
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def find_by_id(id)
    @all.find do |invoice_item|
      invoice_item.id == id
    end
  end

  def find_all_by_item_id(item_id)
    @all.find_all do |invoice_item|
      invoice_item.item_id == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @all.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end





end
