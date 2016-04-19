require './lib/merchant_repository'
require './lib/item_repository'
require './lib/merchant_repository'
require './lib/invoice_repository'
require './lib/invoice_item_repository'
require './lib/transaction_repository'
require './lib/customer_repository'
require 'bigdecimal'

class SalesEngine

  attr_reader :file_hash, :merchant_repository, :item_repository

  def initialize(file_hash)
    @file_hash = file_hash
    @merchant_repository = nil
  end

  def self.from_csv(file_hash)
    SalesEngine.new(file_hash)
  end

  def merchants
    if @merchant_repository != nil
      @merchant_repository
    else
      @merchant_repository = MerchantRepository.new
      data = get_data(file_hash[:merchants])
      generate_instances(data, @merchant_repository, Merchant)
    end
  end

  def items
    if @item_repository != nil
      @item_repository
    else
      @item_repository = ItemRepository.new
      data = get_data(file_hash[:items])
      generate_instances(data, @item_repository, Item)
    end
  end

  def get_data(file)
    CSV.open(file, headers: true, header_converters: :symbol)
  end

  def generate_instances(data, repo, klass)
    data.each do |row|
      repo << klass.new(row, self)
    end
    repo
  end

end
