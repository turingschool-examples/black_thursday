require 'csv'
require './lib/merchantrepository'
require './lib/merchant'



class SalesEngine

  attr_reader :items, :merchants

  def initialize(data)
    @items = data[:items]
    @merchants = data[:merchants]
  end

  def self.from_csv(info)
    SalesEngine.new({ :items => "./data/items.csv",
                      :merchants => "./data/merchants.csv"})
  end

  def merchants
    MerchantRepository.new
  end
  #
  # def items
  # end
end
