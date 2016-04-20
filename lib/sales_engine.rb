require "csv"
require_relative "merchant_repo"
require_relative "item_repo"

class SalesEngine
  attr_accessor :merchants, :items

  def initialize(file_names)
    @merchants = MerchantRepo.new(file_names[:merchants])
    @items = ItemRepo.new(file_names[:items])
  end

  def self.from_csv(file_names)
    SalesEngine.new(file_names)
  end

end
