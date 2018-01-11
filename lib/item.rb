require 'bigdecimal'

class Item

  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id,
              :item_repo

 def initialize(item)
   @id   = item[:id].to_i
   @name = item[:name]
   @description = item[:description]
   @unit_price = BigDecimal.new(item[:unit_price], 4) / 100
   @created_at = Time.parse(item[:created_at])
   @updated_at = Time.parse(item[:updated_at])
   @merchant_id = item[:merchant_id].to_i
   @item_repo = item[:item_repo]
 end

  def self.creator(row, parent)
    new({
      id: row[:id],
      name: row[:name],
      description: row[:description],
      unit_price: row[:unit_price],
      created_at: row[:created_at],
      updated_at: row[:updated_at],
      merchant_id: row[:merchant_id],
      item_repo: parent
    })
  end

  def invoice_items #TESTS
    item_repo.find_invoice_items_by_id(@id)
  end

  def unit_price_to_dollars
    "$#{unit_price.to_f}"
  end

  def merchant
    item_repo.find_merchant(merchant_id)
  end

  def revenue
    invoice_items.reduce(0) do |result, invoice_item|
      result += (invoice_item.unit_price * invoice_item.quantity)
    end
  end

end
