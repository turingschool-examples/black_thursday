require 'pry'

# TO DO -- class was made without item repo class avialble, update & test
# require_relative 'item_repository'
require_relative 'merchant_repository'



class SalesEngine

  attr_reader :items, :merchants

  def initialize
    @items      = nil
    @merchants  = nil
  end

  def self.from_csv(hash)
    self.new
    # binding.pry
    # -- file paths --
    items_path = hash[:items]
    merchants_path = hash[:merchants]
    # -- make repos --
    # @items = ItemRepository.new(items_path)
    @merchants = MerchantRepository.new(merchants_path)
    # binding.pry
    # return self.itself
    # return instance_eval('self')
  end



end
