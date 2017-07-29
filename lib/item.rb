require 'csv'
require 'bigdecimal'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :unit_price_to_dollars,
              :merchant_id,
              :item_repo

  def initialize(item_hash, item_repo)
    @id                    = item_hash[:id].to_i
    @name                  = item_hash[:name]
    @description           = item_hash[:description]
    @price                 = BigDecimal.new((item_hash[:unit_price]))
    @unit_price            = price_create(@price)
    @merchant_id           = item_hash[:merchant_id].to_i
    @created_at            = Time.parse(item_hash[:created_at])
    @updated_at            = Time.parse(item_hash[:updated_at])
    @unit_price_to_dollars = unit_price.to_f
    @item_repo = item_repo
  end

  private

    def price_create(price)
      price/100
    end

    def merchant
      @item_repo.find_merchant_vendor(merchant_id)
    end
end
