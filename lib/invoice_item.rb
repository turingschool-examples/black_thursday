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
    @unit_price = ii_data[:unit_price].to_f
    @created_at = ii_data[:created_at]
    @updated_at = ii_data[:updated_at]
    @repo = repo
  end

  def new_id(id_number)
    @id = id_number
  end
end
