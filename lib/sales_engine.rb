require_relative 'merchant_repo'
require_relative 'item_repo'
require_relative 'sales_relationships'
require_relative 'load_file'

class SalesEngine
  include SalesRelationships
  attr_reader :path
  def initialize(path)
    @path = path
  end

   def self.from_csv(path)
    SalesEngine.new(path)
  end

  def item_repo
    @item_repo ||= ItemRepo.new(LoadFile.load(path[:items]), self)
  end

  def merchant_repo
    @merchant_repo ||= MerchantRepo.new(LoadFile.load(path[:merchants]), self)
  end
end