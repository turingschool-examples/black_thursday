class  InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quanity,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(info)
    @id = info[:id]
    @item_id = info[:item_id]
    @invoice_id = info[:invoice_id]
    @quanity = info[:quanity]
    @unit_price = info[:unit_price]
    @created_at = info[:created_at]
    @updated_at = info[:updated_at]
  end

  # def id(id)
  #   @id
  # end

  # def item_id(item)
  #   @item_id
  # end

  # def invoice_id(invoice)
  #   @invoice_id
  # end

  # def quanity
  #   @quanity
  # end

  # def unit_price
  #   @unit_price
  # end


end