require './lib/merchant_repository'
require './lib/item_repository'
require './lib/merchant_repository'
require './lib/invoice_repository'
require './lib/invoice_item_repository'
require './lib/transaction_repository'
require './lib/customer_repository'

class SalesEngine

  attr_reader :file_hash, :merchant_repository

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
      contents = CSV.open(file_hash[:merchants], headers: true, header_converters: :symbol)
      contents.each do |row|
        @merchant_repository.merchants << Merchant.new(row, self)
      end
      @merchant_repository
    end
  end

  

##for refactoring - to reuse these for all classes
  def get_data(file)

  end

  def generate_instances(data, repo, klass)

  end





end
