class InvoiceItem
  attr_reader :id, :item_id, :invoice_id, :quantity, :unit_price
              :created_at, :updated_at, :repository

  def initialize(invoice_item_hash, repository)
    @repository = repository
    @id = invoice_item_hash[:id].to_i
    @item_id = invoice_item_hash[:item_id].to_i
    @invoice_id = invoice_item_hash[:invoice_id].to_i
    @quantity = invoice_item_hash[:quantity]
    @unit_price = BigDecimal.new(invoice_item_hash[:unit_price]) / 100
    @created_at = Time.parse(invoice_item_hash[:created_at])
    @updated_at = Time.parse(invoice_item_hash[:updated_at])
  end

  # def items
  #   @repository.find_items(@id)
  # end
end
