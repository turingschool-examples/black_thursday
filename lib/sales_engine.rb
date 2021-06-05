require_relative './item_repository'
require_relative './merchant_repository'
require 'csv'

class SalesEngine
  attr_reader :merchants_repo, :items_repo
  def initialize(paths)
    if !paths[:items].nil?
      @items_repo = ItemRepository.new(paths[:items], self)
      @items_repo.generate
    end
    if !paths[:merchants].nil?
      @merchants_repo = MerchantRepository.new(paths[:merchants], self)
      @merchants_repo.generate
    end
  end

  def self.from_csv(paths)
    SalesEngine.new(paths)
  end
end
