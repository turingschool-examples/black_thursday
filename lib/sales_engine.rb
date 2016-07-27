require './lib/item_repo'
require './lib/merchant_repo'
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
      merchant_details = create_initializing_details(row, headers)
      @merchant_repo.add_merchant(merchant_details)
    end
  end

  def add_items_to_repo(item_data)
    headers = item_data.headers
    item_data.each do |row|
      item_details = create_initializing_details(row, headers)
      @item_repo.add_item(item_details)
    end
  end

  def create_initializing_details(entry, headers)
    header_syms = headers.map { |h| h.to_sym }
    header_syms.zip(entry.fields).to_h
  end

  def find_all_items_by_merchant_id(id)
    @item_repo.find_all_by_merchant_id(id)
  end

end
