class InvoiceItem

  attr_reader :id, :item_id, :invoice_item, :quality, :unit_price,
              :created_at, :updated_at, :repository

  def initialize(data, repository)
    @id = data[:id].to_i
    @item_id = data[:item_id].to_i
    @invoice_id = data[:invoice_id].to_i
    @quantity = data[:quantity]
    @unit_price = BigDecimal.new(data[:unit_price])/100
    @created_at = Time.parse(data[:created_at])
    @updated_at = Time.parse(data[:updated_at])
    @repository = repository
  end

=begin
id - returns the integer id
item_id - returns the item id
invoice_id - returns the invoice id
quantity - returns the quantity
unit_price - returns the unit_price
created_at - returns a Time instance for the date the invoice item was first created
updated_at - returns a Time instance for the date the invoice item was last modified
=end

end
