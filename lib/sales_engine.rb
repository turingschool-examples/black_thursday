require 'pry'

# TO DO -- class was made without item repo class avialble, update & test
# require_relative 'item_repository'
require_relative 'merchant_repository'



class SalesEngine

  attr_reader :items, :merchants

  def initialize (items = nil, merchants = nil)
    @items      = items
    @merchants  = merchants
  end

  def self.from_csv(hash)
    merch_reop = make_merch_repo(hash)
    #item_repo = make_item_repo(hash)
    self.new(merch_reop, nil)
  end

  def self.make_merch_repo(hash)
    merchants_path = hash[:merchants]
    @merchants = MerchantRepository.new(merchants_path)
  end

  def self.make_item_repo(hash)
    items_path = hash[:items]
    @items = ItemRepository.new(items_path)
  end

end
#
#
# hash = { :items     => "./data/items.csv",
#           :merchants => "./data/merchants.csv",
#         }
# se = SalesEngine.from_csv(hash)
# binding.pry
