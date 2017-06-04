require_relative '../lib/item_repository'
require 'bigdecimal'


class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id,
              :unit_price_to_dollars,
              :item_repo

  def initialize(item_data, item_repo)
  @item_repo = item_repo
  @id = item_data[:id]
  @name = item_data[:name]
  @description = item_data[:description]
  @unit_price = item_data[:unit_price] #to_i
  @created_at = item_data[:created_at]
  @updated_at = item_data[:updated_at]
  @merchant_id = item_data[:merchant_id]
  end

  def unit_price_to_dollars
    '%.02f' % (unit_price.to_f)
  end

  def merchant
    @item_repo.merchant(self.merchant_id)
  end
end
