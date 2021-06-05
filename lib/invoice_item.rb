class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at,
              :repo

  def initialize(item, repo)
    @id = item[:id].to_i
    @item_id = item[:item_id].to_i
    @invoice_id = item[:invoice_id].to_i
    @quantity = item[:quantity].to_i
    @unit_price = item[:unit_price]
    @created_at = item[:created_at]
    @updated_at = item[:updated_at]
    @repo = repo
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def self.create_invoice_item(attributes, repo)
    data_hash = Hash.new
    data_hash[:id] = repo.new_invoice_item_id
    data_hash[:created_at] = Time.now
    data_hash[:updated_at] = Time.now
    attributes.each do |att, value|
      data_hash[att] = value
    end
    new(data_hash, repo)
  end
end
