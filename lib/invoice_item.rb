require 'pry'
require 'bigdecimal'
require_relative 'finder'


class InvoiceItem
  include Finder

  attr_reader :id,
              :item_id,
              :invoice_id

  attr_accessor :quantity,
                :unit_price,
                :updated_at,
                :created_at

  def initialize(hash)
    # -- Read Only --
    @id = hash[:id]
    @item_id = hash[:item_id]
    @invoice_id = hash[:invoice_id]
    # -- Accessible --
    @quantity = hash[:quantity]
    @unit_price = BigDecimal.new(hash[:unit_price], 4) #.to_f
    @created_at = hash[:created_at]
    @updated_at = hash[:updated_at]
    # TO DO - How to handle -> New creations need Time.now for updated_at, created_at
  end

end
