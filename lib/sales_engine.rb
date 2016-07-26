require './lib/item_repo'
require './lib/merchant_repo'
require 'CSV'
require 'pry'

class SalesEngine
  attr_reader :merchants,
              :items

  def initialize
    @merchants = MerchantRepo.new
    @items     = ItemRepo.new
  end

  def from_csv(csv_path_info)
    if csv_path_info[:merchants]
      merchant_data = CSV.read(csv_path_info[:merchants], headers:true)
      add_merchants_to_repo(merchant_data)
    end
    if csv_path_info[:items]
      item_data = CSV.read(csv_path_info[:items], headers:true)
      add_items_to_repo(item_data)
    end
  end

  def add_merchants_to_repo(merchant_data)
    headers = merchant_data.headers
    merchant_data.each do |row|
      new_merchant = create_initializing_details(row, headers)
      @merchants.add_merchant(new_merchant)
    end
  end

  def add_items_to_repo(item_data)
    headers = item_data.headers
    item_data.each do |row|
      new_item = create_initializing_details(row, headers)
      @items.add_item(new_item)
    end
  end

  def create_initializing_details(entry, headers)
    Hash[headers.collect.with_index do |header, index|
      [header.to_sym, entry[index]]
    end]
  end

end
