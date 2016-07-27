require_relative 'merchant_repository'
require 'csv'

# require './lib/items'
class SalesEngine
  attr_reader :merchants,
              :items

  def initialize(load_paths)
    @load_paths = load_paths
    @merchants =  MerchantRepository.new(read_csv_data(:merchants))
    # @items = ItemRepository.new(read_csv_data)
  end

  def self.from_csv(csv_files)
    SalesEngine.new(csv_files)
  end

  def read_csv_data(repository)
    CSV.read(@load_paths[repository], headers: true, header_converters: :symbol)
  end


  # require "pry"; binding.pry


#   items returns an instance of ItemRepository with all the item instances loaded

# merchants returns an instance of MerchantRepository with all the merchant instances loaded



  # def self.merchants
  #   @MerchantRepository
  # end

  # def self.items
  #   @ItemRepository = ItemRepository.new(true)
  # end
end
