require_relative './item_repo'
require_relative './merchant_repo'
require 'CSV'
require 'pry'

class SalesEngine
  attr_reader :merchant_repo,
              :item_repo

  def initialize(csv_path_info)
    @merchant_repo = MerchantRepo.new(self)
    @item_repo     = ItemRepo.new(self)
    if csv_path_info.class == Hash
      add_data_to_repos(csv_path_info)
    end
  end

  def add_data_to_repos(csv_path_info)
    if csv_path_info[:merchants]
      add_merchants(csv_path_info[:merchants])
    end
    if csv_path_info[:items]
      add_items(csv_path_info[:items])
    end
  end

  def self.from_csv(csv_path_info)
    self.new(csv_path_info)
  end

  def add_merchants(path_info)
    CSV.foreach(path_info, headers:true, header_converters: :symbol) do |row|
      @merchant_repo.add_merchant(row)
    end
  end

  def add_items(path_info)
    CSV.foreach(path_info, headers:true, header_converters: :symbol) do |row|
       @item_repo.add_item(row)
    end
  end
end
