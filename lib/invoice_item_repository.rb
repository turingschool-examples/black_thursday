require_relative 'invoice_item'
require 'bigdecimal'
require 'bigdecimal/util'
require 'time'
require "csv"

class InvoiceItemRepository
  attr_reader :filename,
              :parent,
              :invoice_items

  def initialize(filename, parent)
    @filename = filename
    @parent = parent
    @invoice_items = Array.new
    generate_invoices(filename)
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end

  def generate_invoices(filename)
    invoice_items = CSV.open filename, headers: true, header_converters: :symbol
    invoice_items.each do |row|
      @invoice_items << InvoiceItem.new(row, self)
    end
  end


    def all
      @invoice_items
    end

    def find_by_id(id)
      @invoice_items.find do |invoice_item|
        invoice_item.id.to_i == id
      end
    end

    def find_all_by_item_id(item_id)
      @invoice_items.find_all do |invoice_item|
       invoice_item.item_id.to_i == item_id
      end
    end

    def find_all_by_invoice_id(invoice_id)
      @invoice_items.find_all do |invoice_item|
       invoice_item.invoice_id.to_i == invoice_id
      end
    end

      def create(attributes)
        id = @invoice_items[-1].id.to_i
        id += 1
        id = id.to_i
        attributes[:id] = id
        invoice_item = InvoiceItem.new(attributes, self)
        @invoice_items << invoice_item
      end

    def update(id, attributes)
      update_invoice_item = find_by_id(id)
      update_invoice_item.update(attributes) if !attributes[:quantity].nil?
      update_invoice_item.update(attributes) if !attributes[:unit_price].nil?
      update_invoice_item
    end

    def delete(id)
      delete = find_by_id(id)
      @invoice_items.delete(delete)
    end
  end
