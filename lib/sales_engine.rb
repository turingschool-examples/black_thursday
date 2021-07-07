require_relative "merchant_repository"
require_relative "item_repository"
require_relative "file_loader"
require_relative "repo_helper"
require_relative "sales_analyst"

class SalesEngine
  def initialize(hash)
    @hash = hash
  end

  def self.from_csv(hash)
    new(hash)
  end

  def items
    @items ||= ItemRepository.new(load_file(hash[:items]))
  end

  def merchants
    @merchants ||= MerchantRepository.new(load_file(hash[:merchants]))
  end




end
