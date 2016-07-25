require "csv"
require_relative "item_repo"
require_relative "merchant_repo"

class SalesEngine

  def self.from_csv(files)
    SalesEngine.new(files)
  end

  def initialize(files)
    @files = files
  end

  def merchants
    MerchantsRepo.new(@files[:merchants])
  end

end
