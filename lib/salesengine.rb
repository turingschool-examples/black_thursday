require 'pry'
require 'csv'
require_relative 'itemrepository'
class SalesEngine

  attr_reader :items,
              :merchants

  def initialize(file_path)
    @items = ItemRepository.new(file_path)
    # @merchants = MerchantRepository.new
  end

  def self.from_csv(file = {})
    SalesEngine.new(file[:items])
    # items = ItemRepository.new(file[:items])
    # @merchant_info = CSV.read(file[:merchants])
  end

end
binding.pry
