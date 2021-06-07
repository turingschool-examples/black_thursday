require 'time'

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
    @unit_price = BigDecimal(item[:unit_price]) / 100
    @created_at = Time.parse(item[:created_at])
    @updated_at = Time.parse(item[:updated_at])
    @repo = repo
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def self.create_invoice_item(attributes, repo)
    data_hash = Hash.new
    time = Time.now.utc.strftime("%d-%m-%Y %H:%M:%S %Z")
    data_hash[:id] = repo.new_invoice_item_id
    data_hash[:item_id] = attributes[:item_id]
    data_hash[:invoice_id] = attributes[:invoice_id]
    data_hash[:quantity] = attributes[:quantity]
    data_hash[:unit_price] = attributes[:unit_price]
    data_hash[:created_at] = time
    data_hash[:updated_at] = time
    new(data_hash, repo)
  end

  def update_invoice_item(attributes)
    unless attributes[:quantity].nil?
      @quantity = attributes[:quantity].to_i
    end
    unless attributes[:unit_price].nil?
      @unit_price = attributes[:unit_price]
    end
    @updated_at = Time.now
  end
end
