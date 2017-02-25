require 'pry'
require 'csv'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/merchant'
require_relative '../lib/item'
require_relative '../lib/customer_repository'
require_relative '../lib/customer'


class SalesEngine
  attr_reader :merchants, :items, :customers

  def initialize(files_to_be_loaded)
    @merchants ||= MerchantRepository.new(files_to_be_loaded[:merchants])
    @items ||= ItemRepository.new(files_to_be_loaded[:items])
    @customers ||= CustomerRepository.new(files_to_be_loaded[:customers])
  end

  def self.from_csv(files_to_be_loaded)
    SalesEngine.new(files_to_be_loaded)
  end

end
