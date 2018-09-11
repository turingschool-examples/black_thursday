require_relative 'merchant_repository'
require_relative 'merchant'
require_relative 'item'
require_relative 'item_repository'
require_relative 'csv_adapter'
require_relative 'crud'

require 'csv'

class SalesEngine
include Crud

  attr_reader :filepath
  attr_accessor :merchants

  def initialize(filepath)
    @filepath = filepath
  end

  def self.from_csv(filepath)
    SalesEngine.new(filepath)     
  end

  def create_instance_of_merchants(merchant_array)
     merchant_array.map do |hash|
      Merchant.new(hash)
    end
  end

  def create_instance_of_items(items_array)
    items_array.map do |hash|
     Item.new(hash)
   end
 end

 def merchants
   @merchants ||= MerchantRepository.new(filepath, self)
   @merchants.collection 
 end

#  def loader(filepath)
#    merchant_table = load(filepath)
#     merchant_table.map do |merchant|
#       Merchant.new(merchant, @parent)
#     end
#   end

end



# @merchants ||= MerchantRepository.new(load(filepath[:merchants], self))
