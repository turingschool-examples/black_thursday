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
    #RETURN VALUE IS MERCH REPO
    #check if merch repo is nil or not
    #if nil
      #make a new merch repo object
      #read the data from the csv file
      #go through each row of the data
        #make a new merch object passing in the row and self
        #that new object gets pushed onto the merchant repo



  end



##for refactoring - to reuse these for all classes
  def get_data(file)

  end

  def generate_instances(data, repo, klass)

  end





end
