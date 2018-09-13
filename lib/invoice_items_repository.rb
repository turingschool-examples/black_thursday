require 'pry'

require_relative 'csv_parse'
require_relative 'invoice_item'
require './lib/finder'


class InvoiceItemRepository
  include Finder

  attr_reader :all,
              :invoice_items

  def initialize(path)
    @csv = CSVParse.create_repo(path)
    @invoice_items = []
    make_invoice_items
    @all = invoice_items
  end


  def make_invoice_items

    @csv.each { |key, value|
      number = key.to_s.to_i
      item_id = value[:item_id]
      invoice_id = value[:invoice_id]
      quantity = value[:quantity]
      unit_price = value[:unit_price]
      created_at = value[:created_at]
      updated_at = value[:updated_at]

        invoice_item = InvoiceItem.new({
        id: number, 
        item_id: item_id,
        invoice_id: invoice_id,
        quantity: quantity,
        unit_price: unit_price,
        created_at: created_at,
        updated_at: updated_at
      })
      @invoice_items << invoice_item
    }
    @invoice_items.flatten!
  end

end

# path = './data/invoice_items.csv'
# repo = InvoiceItemRepository.new(path)
# binding.pry