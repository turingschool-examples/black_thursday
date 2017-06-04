require_relative '../lib/item_repository'
require 'bigdecimal'
require 'bigdecimal/util'
require 'time'


class Item
  attr_reader :id,
              :name,
              :description,
              :created_at,
              :updated_at,
              :merchant_id,
              :unit_price_to_dollars,
              :item_repo

  attr_accessor :unit_price

  def initialize(item_data, item_repo)
  @item_repo = item_repo
  @id = item_data[:id].to_i
  @name = item_data[:name]
  @description = item_data[:description]
  @unit_price = ((item_data[:unit_price].to_f)/ 100).to_d
  @created_at = Time.parse(item_data[:created_at])
  @updated_at = Time.parse(item_data[:updated_at])
  @merchant_id = item_data[:merchant_id]
  end

  def unit_price_to_dollars
    @unit_price = '%.02f' % (unit_price.to_f)
  end

  def merchant
    @item_repo.merchant(self.merchant_id)
  end
end
