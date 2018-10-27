class InvoiceItem
  attr_reader :id, :item_id
  def initialize(stats)
    @id = stats[:id]
    @item_id = stats[:item_id]
  end
end
