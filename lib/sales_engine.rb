require_relative "../lib/items_repo"
require_relative "../lib/merchant_repo"
require_relative "../lib/black_thursday_helper"

class SalesEngine
  attr_reader :merchants,
              :items

  def self.from_csv(params)
    merchants = MerchantRepo.new(params[:merchants])
    populate_merchants(params[:merchant])
    items = ItemsRepo.new(params[:items])
    populate_items(params[:items])

    SalesEngine.new(merchants, items)
  end

  def initialize(merchants, items)
    @merchants = merchants
    @items = items
  end

  def populate_merchants(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |data|
      @collections << Merchant.new(data)
    end
  end

  def populate_items(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |data|
      @collections << Item.new(data)
    end
  end
end
