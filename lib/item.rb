require 'time'
require 'bigdecimal'

class Item
  attr_reader :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id,
              :id

  attr_accessor :merchant

  def initialize(info, item_repository)
    @id = info[:id].to_i
    @name = info[:name]
    @description = info[:description]
    @unit_price = BigDecimal.new(info[:unit_price],4)/100
    @created_at = Time.parse(info[:created_at])
    @updated_at = Time.parse(info[:updated_at])
    @merchant_id = info[:merchant_id].to_i
    @item_repository = item_repository
    @merchant = ''
  end

  def merchant
    @item_repository.find_all_by_merchant_id_in_merchant_repo(@merchant_id)
  end

  def invoice_items
    @item_repository.find_all_invoice_items_by_item_id(@id)
  end

end
