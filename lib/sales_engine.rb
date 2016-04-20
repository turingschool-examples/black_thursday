require 'csv'
require './lib/item_repository'
require './lib/merchant_repository'
require 'pry'

class SalesEngine
  attr_reader :merchant_repo, :item_repo, :merchant_contents, :item_contents

  def initialize(merchant_contents, item_contents)
    @merchant_contents = merchant_contents
    @item_contents = item_contents
    @item_repo = ItemRepository.new(self)
    @merchant_repo = MerchantRepository.new(self)
  end

  def self.from_csv(files_to_parse = {})
    item_file = files_to_parse.fetch(:items)
    item_contents = CSV.open item_file, headers: true, header_converters: :symbol

    merchant_file = files_to_parse.fetch(:merchants)
    merchant_contents = CSV.open merchant_file, headers: true, header_converters: :symbol

    SalesEngine.new(merchant_contents, item_contents)
  end

  def merchants
    merchant_repo.merchants(merchant_contents)
  end

  def items
    item_repo.items(item_contents)
  end

  def find_items_by_merch_id(merchant_id)
    item_repo.find_all_by_merchant_id(merchant_id)
  end

  def find_merchant_by_merch_id(id)
    merchant_repo.find_by_id(id)
  end


end

s = SalesEngine.from_csv({:items => "./data/items.csv", :merchants => "./data/merchants.csv"})
s.items
