require 'pry'


require 'bigdecimal'

class InvoiceItem

  attr_reader :id,
              :item_id,
              :invoice_id

  attr_accessor :quantity,
                :unit_price,
                :updated_at,
                :created_at

  def initialize(hash)
    # -- Read Only --
    @id         = hash[:id].to_i
    @item_id    = hash[:item_id].to_i
    @invoice_id = hash[:invoice_id].to_i
    # -- Accessible --
<<<<<<< HEAD
    @quantity = hash[:quantity]
=======
    @quantity   = hash[:quantity].to_i
>>>>>>> 5f399fe8d79407e1d5933ab68e0dfa355e65e7b2
    @unit_price = BigDecimal.new(hash[:unit_price], 4)
    @created_at = hash[:created_at]
    @updated_at = hash[:updated_at]
    # TO DO - How to handle -> New creations need Time.now for updated_at, created_at
  end

end
