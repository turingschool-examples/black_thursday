require_relative './item_repo'
require_relative './merchant_repo'
require 'CSV'
require 'pry'

class SalesEngine
  attr_reader :merchant_repo,
              :item_repo

  def initialize(csv_path_info)
    # we use <type>_repo, rather than just the type
    # as we find this to be clearer
    # e.g. merchant_repo rather than merchants
    @merchant_repo = MerchantRepo.new(self)
    @item_repo     = ItemRepo.new(self)
    if csv_path_info.class == Hash
      add_data_to_repos(csv_path_info)
    end
  end

  def items
    @item_repo
  end

  def merchants
    @merchant_repo
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

  # these methods are for passing child queries
  # into other repos

  def find_all_items_by_merchant_id(id)
    @item_repo.find_all_by_merchant_id(id)
  end

  def find_merchant_by_merchant_id(id)
    @merchant_repo.find_by_id(id)
  end
end
