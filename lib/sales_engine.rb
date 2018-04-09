require 'csv'
require_relative 'merchant_repository'
require_relative 'item_repository'
require 'pry'

class SalesEngine

  attr_reader :item_repository, :merchant_repository
  def initialize(path = filepath)
    @item_repository ||= ItemRepository.new
    @merchant_repository ||= MerchantRepository.new
    load_data(path = filepath)
  end

  def self.from_csv(path = filepath)
    new(path)
  end

  def load_data(path = filepath)
    load_items(path)
    load_merchants(path)
  end

  def filepath
    {
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    }
  end

  def load_items(filepath)
    CSV.foreach(filepath[:items], headers: true, header_converters: :symbol) do |data|
      @item_repository.items << Item.new(data)
    end
  end

  def load_merchants(filepath)
    CSV.foreach(filepath[:merchants], headers: true, header_converters: :symbol) do |merchant|
      @merchant_repository.merchants << Merchant.new(merchant)
    end
  end
end
