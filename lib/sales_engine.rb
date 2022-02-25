require_relative "merchant_repository"
require_relative 'item'
require_relative 'merchant'
require 'csv'
require './lib/sales_analyst.rb'

class SalesEngine
  attr_reader :items_array, :merchants_array
  def initialize
  @items_array = []
  @merchants_array = []
  end
  def self.from_csv(files)
    engine = SalesEngine.new
    items = CSV.open(files[:items], headers: true)
    items.each {|data| engine.items_array << Item.new({:id => data[0], :name => data[1], :description => data[2], :unit_price => data[3], :created_at => Time.now, :updated_at => Time.now, :merchant_id => data[4]})}
    merchants = CSV.open(files[:merchants], headers: true)
    merchants.each {|data| engine.merchants_array << Merchant.new({:id => data[0], :name => data[1]})}
    engine
  end
  def merchants
    MerchantRepository.new(@merchants_array)
  end
  def items
    ItemRepository.new(@items_array)
  end

  def analyst
    SalesAnalyst.new
  end
end
