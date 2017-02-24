require 'ostruct'
require 'csv'
require_relative 'merchant_repository'
require_relative 'item_repository'
require 'pry'


class SalesEngine
  attr_accessor :files

  def initialize(files)
    @files = files
  end

  def self.from_csv(file_hash)
    OpenStruct.new(items: ItemRepository.new(file_hash[:items]), merchants: MerchantRepository.new(file_hash[:merchants]))
  end

end
