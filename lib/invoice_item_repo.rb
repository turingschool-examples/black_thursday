require 'CSV'
require 'time'
require 'bigdecimal'
require 'bigdecimal/util'
require './lib/module'
require './lib/invoice'

class InvoiceItemRepo
  include Methods
  attr_reader :collections

  def populate_collection
    items = Hash.new{|h, k| h[k] = [] }
      CSV.foreach(@data, headers: true, header_converters: :symbol) do |data|
      items[data[:id]] = InvoiceItem.new(data, self)
      end
      items
    end

    def find_all_by_item_id(id)
      all.values.find_all do |value|
        value.item_id == id
      end
    end

    def find_all_by_invoice_id(id)
      all.values.find_all do |value|
        value.invoice_id == id
      end
    end

    def create(attributes)
      @collections[attributes[:id]] = InvoiceItem.new({
      :id         => new_id,
      :item_id    => attributes[:item_id],
      :invoice_id => attributes[:invoice_id],
      :quantity   => attributes[:quantity],
      :unit_price => attributes[:unit_price],
      :created_at => attributes[:created_at],
      :updated_at => attributes[:updated_at]}, self)
    end
end
