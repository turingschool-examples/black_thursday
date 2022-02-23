# require "./data/items"
# require "./data/merchants"
require_relative "merchant_repository"
require_relative 'item'
require_relative 'merchant'
require 'csv'

class SalesEngine
  attr_reader :items, :merchants
    @@items = []
    @@merchants = []

  def self.from_csv(files)
    items = CSV.read(files[:items])
    items.shift(2)
    items.each {|data| @@items << Item.new({:id => data[0], :name => data[1], :description => data[2], :unit_price => data[3], :created_at => Time.now, :updated_at => Time.now, :merchant_id => data[4]})}
    merchants = CSV.read(files[:merchants])
    merchants.shift
    merchants.each {|data| @@merchants << Merchant.new({:id => data[0], :name => data[1]})}
  end

  def self.merchants
    MerchantRepository.new(@@merchants)
  end

  def self.items
    ItemRepository.new(@@items)
  end

end
require "pry"; binding.pry
