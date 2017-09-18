require 'time'
require 'bigdecimal'
require 'csv'

class InvoiceItem

    attr_reader :id,
                :item_id,
                :invoice_id,
                :quantity,
                :unit_price,
                :created_at,
                :updated_at,
                :parent,
                :price


    def initialize(data, repo = nil)
      @id           = data[:id].to_i
      @item_id      = data[:item_id].to_i
      @invoice_id   = data[:invoice_id].to_i
      @quanity      = data[:quantity]
      @price       = BigDecimal.new(data[:unit_price])
      @unit_price  = unit_price_to_dollars(@price)
      @created_at   = Time.parse(data[:created_at].to_s)
      @updated_at   = Time.parse(data[:updated_at].to_s)
      @parent       = repo
    end

    def unit_price_to_dollars(unit_price)
      unit_price / 100
    end
end
