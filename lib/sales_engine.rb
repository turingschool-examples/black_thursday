# frozen_string_literal: true

require 'csv'
require_relative 'merchant_repository'
require_relative 'item_repository'
require 'pry'

# This is a SalesEngine Class
class SalesEngine
  attr_reader :items, :merchants
  def initialize(path)
    @items ||= ItemRepository.new
    @merchants||= MerchantRepository.new
    load_data(path)
  end

  def self.from_csv(path)
    new(path)
  end

  def load_data(path)
    load_items(path)
    load_merchants(path)
  end

  def filepath
    {
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    }
  end

  def load_items(path = filepath)
    CSV.foreach(path[:items], headers: true, header_converters: :symbol) do |data|
      @items.items << Item.new(data)
    end
  end

  def load_merchants(path = filepath)
    CSV.foreach(path[:merchants], headers: true, header_converters: :symbol) do |merchant|
      @merchants.merchants << Merchant.new(merchant)
    end
  end
end
