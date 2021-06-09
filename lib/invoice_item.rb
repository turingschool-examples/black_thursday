class InvoiceItem
attr_reader :id,
            :item_id,
            :invoice_id,
            :quantity,
            :unit_price,
            :created_at,
            :updated_at,
            :repo

  def initialize(ii_data, repo)
    @id = ii_data[:id].to_i
    @item_id = ii_data[:item_id].to_i
    @invoice_id = ii_data[:invoice_id].to_i
    @quantity = ii_data[:quantity].to_i
    @unit_price = BigDecimal(ii_data[:unit_price]) / 100
    @created_at = ii_data[:created_at]
    @updated_at = ii_data[:updated_at]
    @repo = repo
  end

  def new_id(id_number)
    @id = id_number
  end

  def update_quantity(new_quantity)
    @quantity = new_quantity
  end

  def update_unit_price(new_unit_price)
    @unit_price = new_unit_price
  end

  def update_time
   @updated_at = Time.now
  end
end
