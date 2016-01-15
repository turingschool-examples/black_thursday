require 'pry'
require 'time'
require 'bigdecimal'

class Item
  attr_reader :name, :id, :description, :unit_price, :created_at, :updated_at, :merchant_id, :merchant_repo

  def initialize(item_info)
    @name          = item_info[:name]
    @id            = item_info[:id].to_i
    @description   = item_info[:description]
    @unit_price    = BigDecimal.new((item_info[:unit_price].to_f / 100).to_s)
    @created_at    = Time.parse(item_info[:created_at])
    @updated_at    = Time.parse(item_info[:updated_at])
    @merchant_id   = item_info[:merchant_id].to_i
    @merchant_repo = merchant_repo
  end

  def merchant
    #Etsy owner's merchant ID needs to pop up here per every item made
    merchant_repo.find_by_id(self.merchant_id)
  end
end
