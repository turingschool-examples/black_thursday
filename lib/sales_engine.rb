require_relative 'merchant_repository'
require_relative 'merchant'
require_relative 'crud'
require 'csv'
require 'pry'

class SalesEngine
include Crud

  attr_reader :filepath
  attr_accessor :merchants

  def initialize(filepath)
    @merchants = merchants
    @filepath = filepath
    # @merchants = MerchantRepository.new(load(merchants_file))
  end

  def self.from_csv(filepath)
    merchants = MerchantRepository.new(filepath[:merchants])
    # @items = ItemRepository.new(filepath[:items]
  end

  
end
