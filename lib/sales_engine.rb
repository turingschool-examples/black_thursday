require 'ostruct'
require 'csv'
require_relative 'merchant_repository'
require_relative 'item_repository'
require 'pry'
#require_relative '../data/merchants'
#require_relative '../data/items'



class SalesEngine
  attr_accessor :files

  def initialize(files)
    binding.pry
    @files = files
  end

  def self.from_csv(file_hash)
    OpenStruct.new(items: ItemRepository.new(file_hash[:items]), merchants: MerchantRepository.new(file_hash[:merchants]))
  end

  # key =  File.basename(file, ".csv").to_sym
  # @files[key] = file
  #file_hash.each do |type, file_name|
  #  puts type
  #puts file_name
  #end

  # pass the hash of keys to file names
  # instantiate the "children" classes depending on the key we're given

  # bind the objects returned to a method our self class can call.
#
# se = SalesEngine.from_csv({
#   :items     => "./data/items.csv",
#   :merchants => "./data/merchants.csv",
# })
#calling a class method

end
