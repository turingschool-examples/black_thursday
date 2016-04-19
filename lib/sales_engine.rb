require './lib/merchant_repository'
require './lib/item_repository'
require './lib/merchant_repository'
require './lib/invoice_repository'
require './lib/invoice_item_repository'
require './lib/transaction_repository'
require './lib/customer_repository'
require 'csv'

class SalesEngine

  def initialize(file_hash)
    @item_repository = nil
    @merchant_repository = nil
    @data_files =  #go through each k/v in file hash
        #assign @data_files[key] to value
  end

  def self.from_csv(file_hash)
    #intantiate a new se object(file_hash)
  end

  def merchants #similar for items

    #if merchants repo already exists
      #return it

    #else

      #instantiate it - @merch_repo = merch repo.new(self)

      ###MAY BE ABLE TO REPLACE ALL BELOW WITH GET_DATA & GENERATE INSTANCES

      #set source equal to data_files[:merchants]
      #     contents = CSV.open(source, headers: true, header_converters: :symbol)

      #contents.each do |row|
      #   @merch_repo << Merchant.new(row, self)
      # end

    #return merch_repo

  end

  # def get_data(source)
  #     contents = CSV.open(source, headers: true, header_converters: :symbol)
  #end

  # def generate_instances(contents, repo, klass)
  #contents.each do |row|
  #   repo << klass.new(row, self})
  # end
  #end

end
