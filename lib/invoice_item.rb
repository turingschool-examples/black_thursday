class InvoiceItem
  attr_reader :item_id

  def initialize(data)
    @item_id = data[:id]
  end

end
