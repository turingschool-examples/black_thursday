require_relative 'merchant_repository'
require_relative 'item_repository'
require 'csv_parse'

class SalesEngine

  extend ParseCSV

  def self.from_csv(files)
    @merchant_repo = create_merchant_repository(files)
    @item_repo = create_item_repository(files)
    self
  end

  def self.create_merchant_repository(files)
    if files.include?(:merchants)
      MerchantRepository.new(merchant_csv_parse(files[:merchants]))
    end
  end

  def self.create_item_repository(files)
    if files.include?(:items)
      ItemRepository.new(item_csv_parse(files[:items]))
    end
  end

  def self.merchants
    @merchant_repo
  end

  def self.items
    @item_repo
  end

end