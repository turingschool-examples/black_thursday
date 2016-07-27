require_relative './item_repo'
require_relative './merchant_repo'
require 'CSV'
require 'pry'

class SalesEngine
  attr_reader :merchant_repo,
              :item_repo

  def initialize
    @merchant_repo = MerchantRepo.new(self)
    @item_repo     = ItemRepo.new(self)
  end

  def from_csv(csv_path_info)
    if csv_path_info[:merchants]
      merchant_data = CSV.read(csv_path_info[:merchants], headers:true, header_converters: :symbol)
      add_merchants_to_repo(merchant_data)
    end
    if csv_path_info[:items]
      item_data = CSV.read(csv_path_info[:items], headers:true, header_converters: :symbol)
      add_items_to_repo(item_data)
    end
  end

  def add_merchants_to_repo(merchant_data)
    headers = merchant_data.headers
    merchant_data.each do |row|
      @merchant_repo.add_merchant(row.to_hash)
    end
  end

  def add_items_to_repo(item_data)
    headers = item_data.headers
    item_data.each do |row|
      @item_repo.add_item(row.to_hash)
    end
  end

end
