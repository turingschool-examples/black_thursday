require 'csv'
require_relative 'merchant_repository'
require_relative 'item_repository'

class SalesEngine
  attr_reader :files, :merchants, :items

  def initialize(files)
    @files = files
    @merchants = MerchantRepository.new(files[:merchants])
    @items = ItemRepository.new(files[:items])    
  end

  def self.from_csv(files)
    new(files)
  end

end
