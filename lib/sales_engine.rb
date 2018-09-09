require_relative 'merchant_repository'
require 'csv'
require 'pry'

class SalesEngine
include Crud

  attr_reader :filepath
  attr_accessor :merchants

  def initialize(filepath)
    @filepath = filepath
  end

  def self.from_csv(filepath)
    @merchants = MerchantRepository.new(filepath[:merchants])
    # @items = ItemRepository.new(filepath[:items]
  end
end
