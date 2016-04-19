require './lib/merchant_repository'
require './lib/item_repository'
require './lib/merchant_repository'
require './lib/invoice_repository'
require './lib/invoice_item_repository'
require './lib/transaction_repository'
require './lib/customer_repository'
require 'csv'

class SalesEngine

  def initialize
    @item_repository = nil
    @merchant_repository = nil
    @data_files = nil
  end

  def from_csv(file_hash)
    #go through each
    #assign @data_files[key] to value
  end


  def merchants #similar for items

    #if merchants repo already exists
      #return it

    #else
      #instantiate it - @merch_repo = merch repo.new
      #set source equal to data_files[:merchants]

      #     contents = CSV.open(source, headers: true, header_converters: :symbol)

      #contents.each do |row|
      #   merch_repo << Merchant.new({:id => row[:id], :name => row[:name]})
      # end

    #return merch_repo

  end




end
